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


<%inherit file="/site.mako"/>


<%def name="breadcrumb_content()" filter="trim">
    % for ancestor in reversed(list(node.iter_ancestors(skip_self = True))):
            <li>
        % if ancestor.has_view:
                <a href="${ancestor.url_path}">${ancestor.title}</a>
        % else:
                ${ancestor.title}
        % endif
            </li>
        
    % endfor
            <li class="active">${node.title}</li>
</%def>


<%def name="children_list()" filter="trim">
        <ul>
    % for child in node.iter_children(ctx):
            <li>
        % if child.has_view:
                <a href="${child.url_path}">${child.title}</a>
        % else:
                ${child.title}
        % endif
            </li>
    % endfor
        </ul>
</%def>


<%def name="h1_content()" filter="trim">
${node.title or ''}
</%def>


<%def name="page_content()" filter="trim">
        <%self:children_list/>
</%def>


<%def name="title_content()" filter="trim">
${node.title} &mdash; ${parent.title_content()}
</%def>
