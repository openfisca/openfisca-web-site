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
Installing OpenFisca
</%def>


<%def name="page_content()" filter="trim">
    <div role="main">
        <p>
            You need to install OpenFisca on your computer if you want to contribute to the source code
            or run a local instance.
            Operating systems targeted are, among others, GNU/Linux distributions, Mac OS X and Microsoft Windows.
        </p>

        <h3>Installing OpenFisca-Core</h3>
        <p>
          See
          <a href="https://github.com/openfisca/openfisca-core" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-core
          </a>
        </p>

        <h3>Installing OpenFisca-France</h3>
        <p>
          See
          <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-france
          </a>
        </p>

        <h3>Installing OpenFisca-Web-API</h3>
        <p>
          See
          <a href="https://github.com/openfisca/openfisca-web-api" rel="external" target="_blank">
            https://github.com/openfisca/openfisca-web-api
          </a>
        </p>
    </div>
</%def>
