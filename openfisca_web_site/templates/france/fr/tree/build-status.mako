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
import json
import urllib2
import urlparse

from openfisca_web_site import conf
%>


<%page cached="False" />


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Build Status
</%def>


<%def name="page_content()" filter="trim">
<div class="row">
<div class="col-md-6">
<table class="table table-striped">
  <tbody>
  % for repository_name in ['openfisca-core', 'openfisca-france', 'openfisca-web-api']:
    <tr>
      <td>
        <a href="https://github.com/openfisca/${repository_name}" rel="external" target="_blank">${repository_name}</a>
      </td>
      <td>
        <a href="https://travis-ci.org/openfisca/${repository_name}" rel="external" target="_blank">\
<img alt="travis build status" src="https://travis-ci.org/openfisca/${repository_name}.svg?branch=master" />\
</a>
        on branch master
      </td>
    </tr>
  % endfor
  </tbody>
</table>
</div>
</div>
</%def>
