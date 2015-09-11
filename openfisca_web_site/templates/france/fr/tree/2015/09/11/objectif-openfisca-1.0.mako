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
Objectif : OpenFisca 1.0
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    Le projet OpenFisca se prépare à sortir la version 1.0.
  </p>
  <p>
      Cette version:
  </p>
  <ul>
      <li>
          disposera d'une <a href="${urls.get_url(ctx, 'documentation')}">documentation complète</a>
          (en cours de rédaction)
      </li>
      <li>garantira la compatibilité dans le temps des programmes qui utilisent OpenFisca</li>
      <li>
          sera publiée sur le dépôt de paquets Python
          <a href="https://pypi.python.org" rel="external" target="_blank">PyPI</a>
      </li>
  </ul>
  <p class="text-justify">
    Les tâches à accomplir jusqu'au point d'étape 1.0 sont disponibles ici :
    <a href="https://github.com/issues?q=is%3Aopen+user%3Aopenfisca+milestone%3Av1.0" rel="external" target="_blank">
     GitHub issues for milestone v1.0</a>.
  </p>
</%def>
