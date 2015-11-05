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
About OpenFisca
</%def>


<%def name="page_content()" filter="trim">
        <p>
            OpenFisca is a free simulation software for the French tax-benefit system. It allows
            users to easily visualize a great number of taxes and benefits, and to simulate
            the impact of reforms on their households' revenue. It is a educational tool whose
            aim is to help citizens better understand France's tax-benefit system.
        </p>
        <p>
            In the long run, OpenFisca will model the entire tax-benefit
            system as well as its progression. It will also be used to calculate
            the impact of various reforms on the state budget.
        </p>

        <h2>Copyright</h2>
        <p>
            ${
                u'Copyright © {0} OpenFisca Team'.format(u', '.join(
                    unicode(year)
                    for year in range(2011, datetime.date.today().year + 1)
                    ))
            }
        </p>

        <h2 id="licence">License</h2>
        <p>
            OpenFisca is a free software under the
            <a href="http://www.gnu.org/licenses/agpl.html" rel="external" target="_blank">
                GNU Affero General Public License
            </a>
            version 3 or later.
        </p>

        <h2>Source Code</h2>
        <p>
            <a href="https://github.com/openfisca" rel="external" target="_blank">https://github.com/openfisca</a>
        </p>

        <h2>Initial developpers</h2>
        <p>
            Clément Schaff and Mahdi Ben Jelloul (Centre d'analyse stratégique, then Commissariat général à la stratégie
            et à la prospective).
        </p>

        <h2>Code contributors (<em>OpenFisca Team</em>)</h2>
        <ul>
            <li>Mahdi Ben Jelloul</li>
            <li>Christophe Benz</li>
            <li>Claire Bernard</li>
            <li>Léo Bouloc</li>
            <li>Laurence Bouvard</li>
            <li>Grégory Cornu</li>
            <li>Sophie Cottet <span class="label label-success">New</span></li>
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
            <li>Marion Monnet</li>
            <li>Adrien Pacifico</li>
            <li>Florian Pagnoux</li>
            <li>Louise Paul-Delvaux</li>
            <li>Emmanuel Raviart</li>
            <li>Lucile Romanello</li>
            <li>Stanislas Rybak</li>
            <li>Jérôme Santoul</li>
            <li>Clément Schaff</li>
            <li>Matti Schneider</li>
            <li>Romain Soufflet</li>
            <li>Maël Thomas <span class="label label-success">New</span></li>
            <li>Suzanne Vergnolle</li>
        </ul>

        <h2>Special Thanks</h2>
        <ul>
            <li>Antoine Bozio</li>
            <li>Fabien Dell</li>
            <li>Pierre Pezziardi</li>
            <li>Alain Trannoy</li>
        </ul>

        <h2>Our partners</h2>
        <%self:partners/>
</%def>
