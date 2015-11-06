## -*- coding: utf-8 -*-


## OpenFisca -- A versatile microsimulation software
## By: OpenFisca Team <contact@openfisca.fr>
##
## Copyright (C) 2011, 2012, 2013, 2014, 2015 OpenFisca Team
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
from openfisca_web_site import conf, urls
%>


<%inherit file="/france/fr/tree/tools/index.mako"/>


<%def name="h1_content()" filter="trim">
Tools
</%def>


<%def name="page_content()" filter="trim">
<%
    items_node = node.parent.child_from_node(ctx, unique_name = 'elements')
    items_iter = (
        item
        for item in items_node.iter_items()
        if u'tool' in (item.get('tags') or []) and (item.get('country') is None or conf['country'] in item['country'])
        )
%>\
    <p class="text-justify">
        To improve your understanding of OpenFisca, to enhance its tax and benefit formulas,
        to complete the legislation, etc, we develop several web tools for visualization, exploration and
        debug.
    </p>
    <p class="text-justify">
        These tools are also, in themselves, examples of use of the web API of OpenFisca.
    </p>
    <div class="row">
    % for item in items_iter:
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p>${item['description']}</p>
                    </div>
                    <p><a href="${item['source_url']}" class="btn btn-primary" role="button">Use</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
</%def>
