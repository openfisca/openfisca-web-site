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


<%def name="h1_content()" filter="trim">
Exemples d'utilisation de l'API web
</%def>


<%inherit file="/page.mako"/>


<%def name="page_content()" filter="trim">
    <h2 id="exemples-javascript">Exemples d'utilisation de l'API en JavaScript</h2>
<%
    items_node = node.parent.child_from_node(ctx, unique_name = 'elements')
    items_iter = (
        item
        for item in items_node.iter_items(ctx)
        if u'exemple' in (item.get('tags') or [])
        )
%>\
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
                    <p><a href="${item['source_url']}" class="btn btn-primary" role="button">Étudier</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>

    <h2 id="exemples-python">Exemples d'utilisation de l'API en Python</h2>
    <ul>
        <li>
            <i>Notebooks IPython</i> testant différents profils avec l'API :
            <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/</a>
        </li>
        <li>
            Exemples externes
            <ul>
                <li>
                    <a href="http://nbviewer.ipython.org/github/stanislasrybak/openfisca-web-notebook-tests/tree/master/" target="_blank">
                        Exemples en Python, par Stanislas Rybak
                    </a>
                </li>
            </ul>
        </li>
    </ul>

    <h2 id="exemples-r">Exemples d'utilisation de l'API en R</h2>
    <ul>
        <li>
            <i>Notebooks IPython</i> testant différents profils avec l'API :
            <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/</a>
        </li>
    </ul>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/jQuery.dotdotdot/src/js/jquery.dotdotdot.min.js')}"></script>
    <script>
$(function () {
    $(".ellipsis").dotdotdot();
});
    </script>
</%def>
