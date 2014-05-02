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
Projets
</%def>


<%inherit file="/page.mako"/>


<%def name="page_content()" filter="trim">
    <div class="row">
    % for project in node.iter_projects(xtx):
        <div class="col-md-4 col-sm-6" style="height: 180px">
            <h3>${project['title']}</h3>
            <p>${project['description']}</p>
            <p><a class="btn btn-primary" href="${project['source_url']}" role="button">Voir le projet</a></p>
        </div>
    % endfor
    </div>
</%def>

