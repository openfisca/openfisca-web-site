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
from openfisca_web_site import urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Installer OpenFisca
</%def>


<%def name="page_content()" filter="trim">
    <div role="main">
        <p>
            Vous avez besoin d'installer OpenFisca sur votre ordinateur si vous souhaitez contribuer au code source
            ou si vous voulez faire fonctionner une instance locale.
            Les systèmes d'exploitation ciblés sont, entre autres, les distributions GNU/Linux, Mac OS X et
            Microsoft Windows.
        </p>

        <h3>Installer OpenFisca-Core</h3>
        <p>
          Voir
          <a href="https://github.com/openfisca/openfisca-core" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-core
          </a>
        </p>

        <h3>Installer OpenFisca-France</h3>
        <p>
          Voir
          <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-france
          </a>
        </p>

        <h3>Installer OpenFisca-Web-API</h3>
        <p>
          Voir
          <a href="https://github.com/openfisca/openfisca-web-api" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-web-api
          </a>
        </p>
    </div>
</%def>
