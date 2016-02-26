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
Jupyter notebook avec OpenFisca
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    Nous venons de mettre à disposition un nouvel outil expérimental : Jupyter notebook avec OpenFisca pré-installé.
  </p>
  <p>
    Les « notebook » sont une interface web de type question/réponse dans lesquels ont peut taper du code source
    et voir immédiatement le résultat apparaître.
    Voir le <a href="http://jupyter.org/" rel="external" target="_blank">site de Jupyter</a> et
    <a href="https://nbviewer.jupyter.org/github/ipython/ipython/blob/4.0.x/examples/IPython%20Kernel/SymPy.ipynb" rel="external" target="_blank">un exemple de notebook</a>.
  </p>
  <p>
    Cette nouvelle instance de Jupyter notebook est fournie avec les paquets Python d'OpenFisca pré-installés.
    Vous pouvez ainsi écrire du code Python qui utilise OpenFisca sans avoir à l'installer sur votre ordinateur.
  </p>
  <p>
    Vous trouverez ce nouvel outil à l'adresse <a href="https://jupyter.openfisca.fr/">https://jupyter.openfisca.fr/</a>.
  </p>
  <p>
    Pour y avoir accès vous devez disposer d'un compte sur
    <a href="https://github.com/" rel="external" target="_blank">GitHub</a> car il est utilisé pour l'authentification.
    Vous disposerez ainsi de votre espace personnel de stockage dans lequel vous pourrez créer vos notebooks.
  </p>
  <p>
    Chaque compte personnel est initialisé avec un notebook « getting started » que vous pouvez visualiser en lecture seule sur
    <a href="https://github.com/openfisca/openfisca-web-notebook/blob/master/documentation/getting-started.ipynb" rel="external" target="_blank">GitHub</a>.
  </p>
  <p>
    Cet outil est pour l'instant en expérimentation, nous pouvons le faire évoluer à tout moment.
    De ce fait nous vous conseillons très fortement d'exporter vos travaux régulièrement pour les sauvegarder.
  </p>
  <p style="margin-bottom: 10em">
    <img alt="Logo de Jupyter notebook" src="/elements/images/logo-jupyter.svg" />
    <img alt="Logo d'OpenFisca" src="/hotlinks/logo-openfisca.svg" />
  </p>
</%def>
