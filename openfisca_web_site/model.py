# -*- coding: utf-8 -*-


# OpenFisca -- A versatile microsimulation software
# By: OpenFisca Team <contact@openfisca.fr>
#
# Copyright (C) 2011, 2012, 2013, 2014, 2015 OpenFisca Team
# https://github.com/openfisca
#
# This file is part of OpenFisca.
#
# OpenFisca is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# OpenFisca is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


"""The application's model objects"""


import datetime
import logging
import os
import re
import urlparse

from biryani import strings
import lxml.etree
import lxml.html
import webob

from . import contexts, conv, mimetypes, objects, templates, urls, wsgihelpers


day_re = re.compile(r'\d{2}$')
html_parser = lxml.etree.HTMLParser()
log = logging.getLogger(__name__)
month_re = re.compile(r'\d{2}$')
year_re = re.compile(r'\d{4}$')


class AbstractNode(objects.Initable):
    _template = UnboundLocalError
    ctx = None
    in_toc = True  # When False, node should not appear in table of contents.
    parent = None
    title = None
    tree_path = None  # path of node, relative to tree root
    unique_name = None
    url_path = None

    def __init__(self, ctx, parent = None, tree_path = None, unique_name = None, url_path = None):
        assert isinstance(ctx, contexts.Ctx), ctx
        self.ctx = ctx
        if parent is None:
            assert unique_name is None
        else:
            self.parent = parent
            assert unique_name is not None
            self.unique_name = unique_name
        assert tree_path is not None
        self.tree_path = tree_path
        assert url_path is not None
        self.url_path = url_path

    def can_access(self, check = False):
        return None if check else True

    def convert_element_to_article(self, element, updated):
        title_url = None
        for xpath in (
                './/h1',
                './/h2',
                './/h3',
                './/h4',
                './/h5',
                './/h6',
                ):
            heading_elements = element.xpath(xpath)
            if len(heading_elements) > 0:
                title = lxml.html.tostring(heading_elements[0], encoding = unicode, method = 'text').strip()
                # Remove header from article element.
                header_element = None
                for ancestor_element in iter_element_ancestors(heading_elements[0]):
                    if ancestor_element.tag in ('a', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6', 'header', 'hgroup') \
                            or ancestor_element.tag == 'div' and ancestor_element.get('class') == 'page-header':
                        header_element = ancestor_element
                    if ancestor_element.tag == 'a':
                        url, error = conv.pipe(
                            conv.make_input_to_url(),
                            conv.not_none,
                            )(ancestor_element.get('href'), state = self.ctx)
                        if error is None:
                            title_url = url
                header_element.getparent().remove(header_element)
                break
        else:
            title = None
        return dict(
            element = element,
            hash = element.get('id') or strings.slugify(title),
            id = element.get('id'),
            node = self,
            title = title,
            title_url = title_url,
            updated = get_element_time(element, default = updated),
            )

    def init_from_node(self):
        if self.title is None:
            h1_content = self.render_def('h1_content')
            if h1_content:
                self.title = lxml.html.tostring(lxml.html.fragment_fromstring(h1_content, create_parent = 'p'),
                    encoding = unicode, method = 'text').strip()
            else:
                self.title = self.unique_name

    def iter_ancestors(self, skip_self = False):
        if not skip_self:
            yield self
        parent = self.parent
        if parent is not None:
            for ancestor in parent.iter_ancestors():
                yield ancestor

    def iter_articles(self, updated = None):
        page = self.render()
        if page is not None:
            try:
                html_element = lxml.etree.fromstring(page, html_parser)
            except lxml.etree.XMLSyntaxError:
                log.error(u'XML syntax error in {}'.format(self.url_path))
                raise
            article_elements = html_element.xpath('.//article')
            if len(article_elements) == 0:
                body_content_elements = html_element.xpath(
                    'body/div[@class="container"]')
                if body_content_elements:
                    body_content_element = body_content_elements[0]
                    for breadcrumb_element in body_content_element.xpath('*[@class="breadcrumb"]'):
                        breadcrumb_element.getparent().remove(breadcrumb_element)
                    for footer_element in body_content_element.xpath('*[@class="footer"]'):
                        footer_element.getparent().remove(footer_element)
                    yield self.convert_element_to_article(body_content_element, updated)
            elif len(article_elements) == 1:
                yield self.convert_element_to_article(article_elements[0], updated)
            else:
                for article_element in article_elements:
                    if any(
                            ancestor_element.tag == 'article'
                            for ancestor_element in iter_element_ancestors(article_element, skip_self = True)
                            ):
                        # Skip article inside article.
                        continue
                    yield self.convert_element_to_article(article_element, updated)

    def iter_latest_articles(self, updated = None):
        for article in sorted(self.iter_articles(updated = updated),
                key = lambda article: article['updated'],
                reverse = True):
            yield article

    @property
    def path(self):
        if self.tree_path is None:
            return None
        return templates.get_existing_path(self.ctx, u'tree', self.tree_path)

    def render(self, **kw):
        template = self.template
        if template is None:
            return None
        ctx = self.ctx
        return template.render_unicode(
            _ = ctx.translator.ugettext,
            ctx = ctx,
            js = templates.js,
            N_ = lambda message: message,
            node = self,
            qp = templates.qp,
            req = ctx.req,
            **kw).strip()

    def render_def(self, def_name, **kw):
        template = self.template
        if template is None:
            return None
        ctx = self.ctx
        return template.get_def(def_name).render_unicode(
            _ = ctx.translator.ugettext,
            ctx = ctx,
            js = templates.js,
            N_ = lambda message: message,
            node = self,
            qp = templates.qp,
            req = ctx.req,
            **kw).strip()

    def render_not_found(self, **kw):
        ctx = self.ctx
        template_path = os.path.join(os.sep, 'page-not-found.mako')
        template = templates.get_template(ctx, template_path)
        return template.render_unicode(
            _ = ctx.translator.ugettext,
            ctx = ctx,
            js = templates.js,
            N_ = lambda message: message,
            node = self,
            qp = templates.qp,
            req = ctx.req,
            **kw).strip()

    @property
    def root_node(self):
        parent = self.parent
        if parent is None:
            return self
        return parent.root_node

    @property
    def template(self):
        if self._template is UnboundLocalError:
            template_path = self.template_path
            self._template = templates.get_template(self.ctx, template_path) \
                if templates.get_existing_path(self.ctx, template_path.lstrip(u'/')) is not None \
                else None
        return self._template

    @property
    def updated(self):
        return datetime.datetime.fromtimestamp(os.path.getmtime(self.path)).isoformat(),

    @wsgihelpers.wsgify
    def view(self, req):
        if self.template is None:
            ctx = contexts.Ctx(req)
            return wsgihelpers.not_found(ctx, body = self.render_not_found())
        return self.render()


class Directory(AbstractNode):
    hidden_filenames = []

    def child_from_node(self, ctx, unique_name = None):
        return self.from_node(ctx, parent = self, unique_name = unique_name)

    @staticmethod
    def from_node(ctx, parent = None, unique_name = None):
        if parent is None:
            assert unique_name is None
            tree_path = u''
            url_path = u'/'
        else:
            assert unique_name is not None
            tree_path = os.path.join(parent.tree_path, unique_name)
            url_path = urlparse.urljoin(parent.url_path.rstrip(u'/') + u'/', unique_name)
        relative_path = os.path.join(u'tree', tree_path)
        path = templates.get_existing_path(ctx, relative_path)
        if path is not None and os.path.isdir(path):
            python_path = os.path.join(path, u'.index.py')
            if os.path.isfile(python_path):
                scope = dict(
                    __builtins__ = __builtins__,  # __builtin__ module (without "s")
                    __doc__ = None,
                    # Without it __name__ == '__main__'.
                    __name__ = os.path.splitext(python_path)[0].replace(os.pathsep, '.'),
                    __package__ = None,
                    )
                execfile(python_path, scope)
                cls = scope['Node']
                assert issubclass(cls, AbstractNode), cls
            else:
                cls = Directory
        else:
            python_relative_path = os.path.join(os.path.dirname(relative_path),
                u'.{}.py'.format(os.path.basename(relative_path)))
            python_path = templates.get_existing_path(ctx, python_relative_path)
            if python_path is not None and os.path.isfile(python_path):
                scope = dict(
                    __builtins__ = __builtins__,  # __builtin__ module (without "s")
                    __doc__ = None,
                    # Without it __name__ == '__main__'.
                    __name__ = os.path.splitext(python_path)[0].replace(os.pathsep, '.'),
                    __package__ = None,
                    )
                execfile(python_path, scope)
                cls = scope['Node']
                assert issubclass(cls, AbstractNode), cls
            else:
                cls = File
        self = cls(ctx, parent = parent, tree_path = tree_path, unique_name = unique_name, url_path = url_path)
        self.init_from_node()
        return self

    @property
    def has_view(self):
        return self.path is not None

    def iter_children(self):
        for child_unique_name in self.iter_children_unique_name():
            yield self.child_from_node(self.ctx, unique_name = child_unique_name)

    def iter_children_unique_name(self, reverse = False):
        hidden_filenames = set(self.hidden_filenames)
        for filename in sorted(os.listdir(self.path), reverse = reverse):
            if filename.startswith('.'):
                # Skip hidden files.
                continue
            if filename.endswith('~'):
                # Skip backup files.
                continue
            if filename in hidden_filenames:
                continue
            yield filename

    def route(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        if self.path is None:
            return wsgihelpers.not_found(ctx, body = self.render_not_found())(environ, start_response)
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)

    def route_child(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        filename, error = conv.not_none(req.urlvars.get('name'), state = ctx)
        child = self.child_from_node(ctx, unique_name = filename or u'')
        if error is not None:
            return wsgihelpers.not_found(ctx, body = child.render_not_found())(environ, start_response)
        if filename.startswith('.') or filename.endswith('~') or filename in self.hidden_filenames:
            return wsgihelpers.not_found(ctx, body = child.render_not_found())(environ, start_response)

        return child.route(environ, start_response)

    @property
    def routings(self):
        return (
            ('GET', '^/?$', self.view),
            (None, '^/(?P<name>[^/]+)(?=/|$)', self.route_child),
            )

    @property
    def template(self):
        if self._template is UnboundLocalError:
            template_path = self.template_path
            if templates.get_existing_path(self.ctx, template_path.lstrip(u'/')) is None:
                template_path = os.path.join(os.sep, 'directory.mako')
            self._template = templates.get_template(self.ctx, template_path)
        return self._template

    @property
    def template_path(self):
        return os.path.join(os.sep, 'tree', self.tree_path, '.index.mako')


class File(AbstractNode):
    mime_type = None

    @property
    def has_view(self):
        return self.path is not None

    def route(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        if self.path is None:
            return wsgihelpers.not_found(ctx, body = self.render_not_found())(environ, start_response)
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)

    @property
    def routings(self):
        return (
            ('GET', '^/?$', self.view),
            )

    @property
    def template_path(self):
        tree_path = self.tree_path
        template_tree_path = os.path.join(os.path.dirname(tree_path), u'.{}.mako'.format(os.path.basename(tree_path)))
        return os.path.join(os.sep, 'tree', template_tree_path)

    @wsgihelpers.wsgify
    def view(self, req):
        response = req.response
        # The with below doesn't work because file will be closed before webob response has read it.
        # with open(self.path) as data_file:
        data_file = open(self.path)
        if self.mime_type is None:
            block = data_file.read(4096)  # File type detection may require up to 4KB of file head.
            response.content_type = mimetypes.magic_scanner.buffer(block)
            data_file.seek(0)
        else:
            response.content_type = self.mime_type
        response.body_file = data_file
        # Don't close data_file.
        return response


class Folder(AbstractNode):
    hidden_names = [
        u'index',  # Skip index in children.
        ]

    def child_from_node(self, ctx, unique_name = None):
        return self.from_node(ctx, parent = self, unique_name = unique_name)

    @staticmethod
    def from_node(ctx, parent = None, unique_name = None):
        if parent is None:
            assert unique_name is None
            tree_path = u''
            url_path = u'/'
        else:
            assert unique_name is not None
            tree_path = os.path.join(parent.tree_path, unique_name)
            url_path = urlparse.urljoin(parent.url_path.rstrip(u'/') + u'/', unique_name)
        relative_path = os.path.join(u'tree', tree_path)
        path = templates.get_existing_path(ctx, relative_path)
        if path is not None and os.path.isdir(path):
            python_path = os.path.join(path, u'index.py')
            if os.path.isfile(python_path):
                scope = dict(
                    __builtins__ = __builtins__,  # __builtin__ module (without "s")
                    __doc__ = None,
                    # Without it __name__ == '__main__'.
                    __name__ = os.path.splitext(python_path)[0].replace(os.pathsep, '.'),
                    __package__ = None,
                    )
                execfile(python_path, scope)
                cls = scope['Node']
                assert issubclass(cls, AbstractNode), cls
            else:
                cls = Folder
        else:
            python_path = templates.get_existing_path(ctx, relative_path + u'.py')
            if python_path is not None and os.path.isfile(python_path):
                scope = dict(
                    __builtins__ = __builtins__,  # __builtin__ module (without "s")
                    __doc__ = None,
                    # Without it __name__ == '__main__'.
                    __name__ = os.path.splitext(python_path)[0].replace(os.pathsep, '.'),
                    __package__ = None,
                    )
                execfile(python_path, scope)
                cls = scope['Node']
                assert issubclass(cls, AbstractNode), cls
            else:
                cls = Page
        self = cls(ctx, parent = parent, tree_path = tree_path, unique_name = unique_name, url_path = url_path)
        self.init_from_node()
        return self

    @property
    def has_view(self):
        return self.template is not None

    def iter_children(self):
        for child_unique_name in self.iter_children_unique_name():
            yield self.child_from_node(self.ctx, unique_name = child_unique_name)

    def iter_children_unique_name(self, reverse = False):
        children_unique_name = set(self.hidden_names)
        for filename in sorted(os.listdir(self.path), reverse = reverse):
            if filename.startswith('.'):
                # Skip hidden files.
                continue
            if filename.endswith('~'):
                # Skip backup files.
                continue
            child_unique_name = os.path.splitext(filename)[0]
            if child_unique_name in children_unique_name:
                continue
            children_unique_name.add(child_unique_name)
            yield child_unique_name

    def iter_latest_articles(self, updated = None):
        ctx = self.ctx
        for year in self.iter_children_unique_name(reverse = True):
            if year_re.match(year) is None:
                continue
            year_node = self.child_from_node(ctx, unique_name = year)
            if not year_node.can_access():
                continue
            for month in year_node.iter_children_unique_name(reverse = True):
                if month_re.match(month) is None:
                    continue
                month_node = year_node.child_from_node(ctx, unique_name = month)
                if not month_node.can_access():
                    continue
                for day in month_node.iter_children_unique_name(reverse = True):
                    if day_re.match(day) is None:
                        continue
                    day_node = month_node.child_from_node(ctx, unique_name = day)
                    if not day_node.can_access():
                        continue
                    updated = datetime.date(int(year), int(month), int(day)).isoformat()
                    for child_unique_name in day_node.iter_children_unique_name():
                        child = day_node.child_from_node(ctx, unique_name = child_unique_name)
                        if not child.can_access():
                            continue
                        for article in child.iter_latest_articles(updated = updated):
                            yield article

    def route(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        if self.path is None:
            return wsgihelpers.not_found(ctx, body = self.render_not_found())(environ, start_response)
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)

    def route_child(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        name, error = conv.not_none(req.urlvars.get('name'), state = ctx)
        child = self.child_from_node(ctx, unique_name = name or u'')
        if error is not None:
            return wsgihelpers.not_found(ctx, body = child.render_not_found())(environ, start_response)
        if name in self.hidden_names:
            return wsgihelpers.not_found(ctx, body = child.render_not_found())(environ, start_response)

        return child.route(environ, start_response)

    @property
    def routings(self):
        return (
            ('GET', '^/?$', self.view),
            (None, '^/(?P<name>[^/]+)(?=/|$)', self.route_child),
            )

    @property
    def template_path(self):
        return os.path.join(os.sep, 'tree', self.tree_path, 'index.mako')


class Page(AbstractNode):
    @property
    def has_view(self):
        return self.template is not None

    def route(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        if self.template is None:
            return wsgihelpers.not_found(ctx, body = self.render_not_found())(environ, start_response)
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)

    @property
    def routings(self):
        return (
            ('GET', '^/?$', self.view),
            )

    @property
    def template_path(self):
        return os.path.join(os.sep, 'tree', self.tree_path + '.mako')


class Redirect(AbstractNode):
    code = 301  # Moved Permanently
    in_toc = False
    location = None

    @wsgihelpers.wsgify
    def redirect(self, req):
        ctx = contexts.Ctx(req)

        return wsgihelpers.redirect(ctx, code = self.code, location = self.location)

    def route(self, environ, start_response):
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)

    @property
    def routings(self):
        return (
            ('GET', '^/?$', self.redirect),
            )


def get_element_time(element, default = None):
    for time_element in element.xpath('.//time[@pubdate]'):
        for ancestor_element in iter_element_ancestors(time_element, skip_self = True):
            if ancestor_element is element:
                return time_element.get('datetime') or time_element.text
            if ancestor_element.tag == 'article':
                # This time is the publication time of another article. Ignore it.
                continue
    return default


def iter_element_ancestors(element, skip_self = False):
    if not skip_self:
        yield element
    parent = element.getparent()
    if parent is not None:
        for ancestor in iter_element_ancestors(parent):
            yield ancestor


def iter_merged_latest_articles(*latest_articles_iterables):
    article_iterable_couples_by_updated = dict()
    for iterable in latest_articles_iterables:
        iterable = iter(iterable)
        try:
            article = iterable.next()
        except StopIteration:
            continue
        article_iterable_couples_by_updated.setdefault(article['updated'], []).append((article, iterable))
    while article_iterable_couples_by_updated:
        last_updated = sorted(article_iterable_couples_by_updated.iterkeys(), reverse = True)[0]
        article_iterable_couples = article_iterable_couples_by_updated[last_updated]
        while article_iterable_couples:
            article, iterable = article_iterable_couples.pop(0)
            yield article
            try:
                article = iterable.next()
            except StopIteration:
                continue
            article_iterable_couples_by_updated.setdefault(article['updated'], []).append((article, iterable))
        del article_iterable_couples_by_updated[last_updated]
