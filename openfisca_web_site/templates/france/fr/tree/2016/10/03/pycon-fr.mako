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
PYCONfr Rennes 2016
</%def>


<%def name="page_content()" filter="trim">
  <p>
    OpenFisca participe à la conférence Python France (PYCONfr) édition 2016 à Rennes.
    La présentation s'intitule « Libération du calculateur des impôts »,
    voir le <a href="https://2016.pycon.fr/pages/programme.html#Libération du calculateur des impôts">descriptif</a>.
  </p>
  <p>
    Voir les slides
    <a href="https://openfisca.github.io/communication/PyConFR-2016/" rel="external" target="_blank">en ligne</a>,
    <a href="https://github.com/openfisca/communication/blob/master/docs/PyConFR-2016/%C3%89crire%20la%20loi%20en%20Python.pdf" rel="external" target="_blank">en PDF</a>
    ou sur
    <a href="https://speakerdeck.com/cbenz/ecrire-la-loi-en-python" rel="external" target="_blank">Speaker Deck</a>.
  </p>
  <script async class="speakerdeck-embed" data-id="863108f704be4c9dbb252f489fed8bb7" data-ratio="1.33159947984395" src="//speakerdeck.com/assets/embed.js"></script>
</%def>
