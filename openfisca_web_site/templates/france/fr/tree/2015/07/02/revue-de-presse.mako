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
Revue de presse
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    France Stratégie a publié une étude utilisant OpenFisca comme modèle de simulation :
    <a href="http://www.strategie.gouv.fr/publications/partager-equitablement-cout-enfants-apres-separation" rel="external" target="_blank">
      Comment partager équitablement le coût des enfants après la séparation ?
    </a>.
  </p>
  <p class="text-justify">
    Différents journaux ont publié des articles à ce sujet :
    <a href="http://www.ledauphine.com/france-monde/2015/06/18/separations-le-cout-net-des-enfants-plus-lourd-pour-le-parent-qui-n-a-pas-la-garde" rel="external" target="_blank">
      le Dauphiné
    </a>,
    <a href="http://www.europe1.fr/societe/separation-et-garde-des-enfants-qui-trinque-le-plus-financierement-1357628" rel="external" target="_blank">
      Europe 1
    </a>,
    <a href="http://www.franceinter.fr/emission-leco-du-jour-fonds-de-pensions" rel="external" target="_blank">
      France Inter
    </a>, et
    <a href="http://www.huffingtonpost.fr/stephanie-lamy/simulation-pension-alimentaire_b_7677924.html" rel="external" target="_blank">
      le Huffington Post
    </a>
  </p>
  <p class="text-justify">
    Par ailleurs l'IDEP (Institut d'Économie Publique) a publié une analyse :
    <a href="http://www.idep-fr.org/sites/default/files/idep/idep_analyses_n6.pdf" rel="external" target="_blank">
      Fiscalité des familles aisées : vers une forfaitarisation de l’enfant
    </a>.
  </p>
</%def>
