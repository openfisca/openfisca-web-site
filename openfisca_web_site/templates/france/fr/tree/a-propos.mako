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
import datetime
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
À propos d'OpenFisca
</%def>


<%def name="page_content()" filter="trim">
        <p>
            OpenFisca est un logiciel libre de simulation du système socio-fiscal français.
            Il permet de visualiser simplement un grand nombre de prestations sociales et d'impôts payés,
            par les ménages, et de simuler l'impact de réformes sur leur revenu.
            Il s'agit d'un outil à vocation pédagogique pour aider les citoyens à mieux comprendre le système
            socio-fiscal.
        </p>
        <p>
            À terme, OpenFisca intégrera l'ensemble du système socio-fiscal français et son évolution et permettra de
            calculer l'impact de réformes sur le budget de l'État.
        </p>

        <h2>Droits d'auteur</h2>
        <p>
            ${
                u'Copyright © {0} OpenFisca Team'.format(u', '.join(
                    unicode(year)
                    for year in range(2011, datetime.date.today().year + 1)
                    ))
            }
        </p>

        <h2 id="licence">Licence</h2>
        <p>
            OpenFisca est un logiciel libre sous licence
            <a href="http://www.gnu.org/licenses/agpl.html" rel="external" target="_blank">
                GNU Affero General Public License
            </a>
            version 3 ou ultérieure.
        </p>

        <h2>Code source</h2>
        <p>
            <a href="https://github.com/openfisca" rel="external" target="_blank">https://github.com/openfisca</a>
        </p>

        <h2>Développeurs initiaux</h2>
        <p>
            Clément Schaff et Mahdi Ben Jelloul (Centre d'analyse stratégique, puis Commissariat général à la stratégie
            et à la prospective).
        </p>

        <h2>Contributeurs au code (<em>OpenFisca Team</em>)</h2>
        <ul>
            <li>Mahdi Ben Jelloul</li>
            <li>Christophe Benz</li>
            <li>Claire Bernard</li>
            <li>Léo Bouloc</li>
            <li>Laurence Bouvard</li>
            <li>Grégory Cornu</li>
            <li>Pierre-Yves Cusset</li>
            <li>Félix Defrance</li>
            <li>Jérôme Desbœufs</li>
            <li>Sarah Dijols</li>
            <li>Alexis Eidelman</li>
            <li>Adrien Fabre</li>
            <li>Emmanuel Gratuze</li>
            <li>Malka Guillot</li>
            <li>Arnaud Kleinpeter</li>
            <li>Victor Le Breton</li>
	    <li>Marion Monnet <span class="label label-success">Nouveau</span></li>
            <li>Adrien Pacifico</li>
            <li>Louise Paul-Delvaux</li>
            <li>Emmanuel Raviart</li>
	    <li>Lucile Romanello <span class="label label-success">Nouveau</span></li>
            <li>Stanislas Rybak</li>
            <li>Jérôme Santoul</li>
            <li>Clément Schaff</li>
            <li>Romain Soufflet</li>
            <li>Suzanne Vergnolle</li>
        </ul>

        <h2>Remerciements</h2>
        <ul>
            <li>Antoine Bozio</li>
            <li>Fabien Dell</li>
            <li>Pierre Pezziardi <span class="label label-success">Nouveau</span></li>
            <li>Alain Trannoy</li>
        </ul>

        <h2>Porteurs du projet</h2>
        <%self:partners/>
</%def>
