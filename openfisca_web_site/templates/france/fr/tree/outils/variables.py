# -*- coding: utf-8 -*-


# OpenFisca -- A versatile microsimulation software
# By: OpenFisca Team <contact@openfisca.fr>
#
# Copyright (C) 2011, 2012, 2013, 2014 OpenFisca Team
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


import collections
import json
import os
import urllib
import urllib2
import urlparse

import webob

from openfisca_web_site import conf, contexts, conv, model, urls, wsgihelpers


class Node(model.Page):
    def child_from_node(self, ctx, unique_name = None):
        return Variable.from_node(ctx, parent = self, unique_name = unique_name)

    def route_child(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        variable_name, error = conv.pipe(
            conv.cleanup_line,
            conv.not_none,
            )(req.urlvars.get('name'), state = ctx)
        child = self.child_from_node(ctx, unique_name = variable_name or u'')
        if error is not None:
            return wsgihelpers.not_found(ctx, body = child.render_not_found())(environ, start_response)

        return child.route(environ, start_response)

    @property
    def routings(self):
        return super(Node, self).routings + (
            (None, '^/(?P<name>[^/]+)(?=/|$)', self.route_child),
            )


class Variable(model.Page):
    holder = None
    name = None

    @staticmethod
    def from_node(ctx, parent = None, unique_name = None):
        assert parent is not None
        assert unique_name is not None
        tree_path = os.path.join(os.path.dirname(parent.tree_path), 'variable')
        url_path = urlparse.urljoin(parent.url_path.rstrip(u'/') + u'/', unique_name)
        self = Variable(ctx, parent = parent, tree_path = tree_path, unique_name = unique_name, url_path = url_path)
        self.init_from_node(ctx)
        return self

    def init_from_node(self, ctx):
        request = urllib2.Request(
            urlparse.urljoin(conf['{}.api.url'.format(ctx.country)], '/api/1/field?variable={}'.format(urllib.quote(self.unique_name))),
            headers = {
                'User-Agent': 'OpenFisca-Web-Site',
                },
            )
        try:
            response = urllib2.urlopen(request)
        except urllib2.HTTPError as response:
            self.title = self.unique_name
        else:
            response_json = json.loads(response.read(), object_pairs_hook = collections.OrderedDict)
            self.holder = holder = response_json['value']
            label = holder.get('label')
            self.name = holder['name']
            self.title = u'{} ({})'.format(label, holder['name']) if label else holder['name']

    def route(self, environ, start_response):
        req = webob.Request(environ)
        ctx = contexts.Ctx(req)

        if self.name is None:
            return wsgihelpers.not_found(ctx, body = self.render_not_found())(environ, start_response)
        http_error = self.can_access(check = True)
        if http_error is not None:
            return http_error(environ, start_response)

        router = urls.make_router(*self.routings)
        return router(environ, start_response)
