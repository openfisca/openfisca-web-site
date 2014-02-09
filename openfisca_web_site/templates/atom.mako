## -*- coding: utf-8 -*-


## OpenFisca -- A versatile microsimulation software
## By: OpenFisca Team <contact@openfisca.fr>
##
## Copyright (C) 2011, 2012, 2013, 2014 OpenFisca Team
## https://github.com/openfisca
##
## This file is part of OpenFisca.
##
## OpenFisca is free software; you can redistribute it and/or modify
## it under the terms of the GNU Affero General Public License as
## published by the Free Software Foundation, either version 3 of the
## License, or (at your option) any later version.
##
## OpenFisca is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU Affero General Public License for more details.
##
## You should have received a copy of the GNU Affero General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.


<%!
##import datetime
import itertools

import lxml.html
import markupsafe

from openfisca_web_site import conf, model, urls
%>


<%def name="feed_author()" filter="trim">
##    <author>
##        <name>YOUR NAME</name>
##        <email>YOUR EMAIL</email>
##        <uri>YOUR URL</uri>
##    </author>
</%def>


<%def name="feed_rights()" filter="trim">
##    <rights>
##        Copyright © ${datetime.date.today().year} YOUR NAME.
##        Verbatim copying and distribution of this entire article is
##        permitted in any medium, provided this notice is preserved.
##    </rights>
</%def>


<?xml version="1.0" encoding="utf-8"?>
<feed xmlns="http://www.w3.org/2005/Atom">
    <title>${conf['realm']}</title>
    <id>${urls.get_full_url(ctx, 'atom')}</id>
    <link href="${urls.get_full_url(ctx)}"/>
    <link href="${urls.get_full_url(ctx, 'atom')}" rel="self"/>
    <%self:feed_author/>
##    % for tag in (tags or []):
##          <category term="${tag}"/>
##    % endfor
    <generator uri="https://github.com/openfisca">Wepubit</generator>
    <%self:feed_rights/>
<%
    last_articles = list(itertools.islice(node.parent.iter_latest_articles(ctx), 10))
%>\
    % if last_articles:
    <updated>${last_articles[0]['updated']}</updated>
    % endif
    % for article in last_articles:
<%
        article_node = article['node']
%>\
    <entry>
        % if article.get('title') is not None:
        <title>${article['title']}</title>
        % endif
        <id>${urls.get_full_url(ctx, article_node.url_path)}${
                u'#{}'.format(article['hash']) if article.get('hash') is not None else u''}</id>
        <link href="${urls.get_full_url(ctx, article_node.url_path)}${
                u'#{}'.format(article['id']) if article.get('id') is not None else u''}"/>
##        % for tag in (dataset.tags or []):
##        <category term="${tag}"/>
##        % endfor
        <updated>${article['updated']}</updated>
        <content type="html">
            ${markupsafe.escape(lxml.html.tostring(article['element'], encoding = unicode))}
        </content>
    </entry>
    % endfor
</feed>
