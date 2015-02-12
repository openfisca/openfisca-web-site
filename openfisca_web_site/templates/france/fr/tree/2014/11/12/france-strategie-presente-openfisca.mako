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
France Stratégie présente OpenFisca
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    France Stratégie a publié une jolie infographie concernant OpenFisca ainsi qu'une plaquette de présentation
    <a href="http://www.strategie.gouv.fr/publications/openfisca-un-logiciel-libre-simuler-reformes-fiscales-sociales" \
rel="external" target="_blank">
      sur son site
    </a>.
  </p>
  <img alt="Infographie OpenFisca de France Stratégie" src="/elements/images/infographie_open_fisca.png" />


</%def>
