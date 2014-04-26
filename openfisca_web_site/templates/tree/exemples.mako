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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Exemples d'utilisation de l'API web
</%def>


<%def name="page_content()" filter="trim">
        <h2 id="exemples-javascript">Exemples d'utilisation de l'API en JavaScript</h2>
        <ul>
            <li><a href="exemple-tableau">Exemple de tableau de décomposition du revenu disponible</a></li>
            <li><a href="exemple-waterfall">Exemple de waterfall du revenu disponible</a></li>
            <li><a href="exemple-trace">Exemple de trace d'une simulation</a></li>
            <li><a href="graphe-formules">Graphe des dépendances des variables et des formules socio-fiscales</a></li>
            <li><a href="variables">Visualisation des variables et des formules socio-fiscales</a></li>
        </ul>

        <h2 id="exemples-python">Exemples d'utilisation de l'API en Python</h2>
        <ul>
            <li>
                <i>Notebooks IPython</i> testant différents profils avec l'API :
                <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/</a>
            </li>
            <li>
                Exemples externes
                <ul>
                    <li>
                        <a href="http://nbviewer.ipython.org/github/stanislasrybak/openfisca-web-notebook-tests/tree/master/" target="_blank">
                            Exemples en Python, par Stanislas Rybak
                        </a>
                    </li>
                </ul>
            </li>
        </ul>

        <h2 id="exemples-r">Exemples d'utilisation de l'API en R</h2>
        <ul>
            <li>
                <i>Notebooks IPython</i> testant différents profils avec l'API :
                <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/</a>
            </li>
        </ul>
</%def>
