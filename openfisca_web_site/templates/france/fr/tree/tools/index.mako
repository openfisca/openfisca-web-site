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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Outils
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
        Pour vous aider à mieux comprendre le fonctionnement d'OpenFisca, à améliorer ses formules socio-fiscales,
        à compléter la législation, etc, nous développons différents outils web de visualisation, d'exploration et de
        déboguage.
    </p>
    <p class="text-justify">
        Ces outils sont aussi, en eux-mêmes, des exemples d'utilisation de l'API web OpenFisca.
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
                    <p><a href="${item['source_url']}" class="btn btn-primary" role="button">Voir</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_static_url(ctx, u'/bower/jQuery.dotdotdot/src/js/jquery.dotdotdot.min.js')}"></script>
    <script>
$(function () {
    $(".ellipsis").dotdotdot();
});
    </script>
</%def>
