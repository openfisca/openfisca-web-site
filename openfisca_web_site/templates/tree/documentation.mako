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
from openfisca_web_site import urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Documentation
</%def>


<%def name="page_content()" filter="trim">
<%
    items_node = node.parent.child_from_node(ctx, unique_name = 'elements')
%>\
    <ul>
        <li><a href="${urls.get_url(ctx, 'presentation')}">Présentation</a></li>
        <li><a href="${urls.get_url(ctx, 'api')}">API web</a></li>
        <li><a href="${urls.get_url(ctx, 'exemples')}">Exemples d'utilisation de l'API web</a>
<%
    items_iter = (
        item
        for item in items_node.iter_items(ctx)
        if u'exemple' in (item.get('tags') or [])
        )
%>\
            <ul>
    % for item in items_iter:
                <li><a href="${item['source_url']}">${item['title']}</a></li>
    % endfor
            </ul>
        </li>
        <li><a href="${urls.get_url(ctx, 'outils')}">Outils</a>
<%
    items_iter = (
        item
        for item in items_node.iter_items(ctx)
        if u'outil' in (item.get('tags') or [])
        )
%>\
            <ul>
    % for item in items_iter:
                <li><a href="${item['source_url']}">${item['title']}</a></li>
    % endfor
            </ul>
        </li>
        <li><a href="${urls.get_url(ctx, 'installation')}">Installation</a>
            <ul>
                <li><a href="${urls.get_url(ctx, 'installation')}#gnu-linux">Debian GNU/Linux</a></li>
                <li><a href="${urls.get_url(ctx, 'installation')}#heroku">Heroku</a></li>
                <li><a href="${urls.get_url(ctx, 'installation')}#mac">Mac OS</a></li>
                <li><a href="${urls.get_url(ctx, 'installation')}#windows">Windows</a></li>
                <li><a href="${urls.get_url(ctx, 'installation')}#version-initiale">Version initiale</a></li>
            </ul>
        </li>
        <li><a href="${urls.get_url(ctx, 'projets')}">Projets</a>
<%
    items_iter = (
        item
        for item in items_node.iter_items(ctx)
        if u'projet' in (item.get('tags') or [])
        )
%>\
            <ul>
    % for item in items_iter:
                <li><a href="${item['source_url']}">${item['title']}</a></li>
    % endfor
            </ul>
        </li>
        <li><a href="${urls.get_url(ctx, 'utilisations')}">Utilisations</a>
<%
    items_iter = (
        item
        for item in items_node.iter_items(ctx)
        if u'utilisation' in (item.get('tags') or [])
        )
%>\
            <ul>
    % for item in items_iter:
                <li><a href="${item['source_url']}">${item['title']}</a></li>
    % endfor
            </ul>
        </li>
        <li><a href="${urls.get_url(ctx, 'contribuer')}">Contribuer à OpenFisca</a></li>
        <li><a href="${urls.get_url(ctx, 'mentions-legales')}">Mentions légales</a></li>
    </ul>
</%def>
