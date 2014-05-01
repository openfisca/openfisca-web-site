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
Utilisations
</%def>


<%inherit file="/page.mako"/>


<%def name="page_content()" filter="trim">
    <div class="row">
    % for visualization in node.iter_visualizations(xtx):
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <img src="${visualization['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${visualization['title']}</h3>
                        <p>${visualization['description']}</p>
                    </div>
                    <p><a href="${visualization['source_url']}" class="btn btn-primary" role="button">Voir</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
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
