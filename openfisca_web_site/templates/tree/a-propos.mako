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


<%!
import datetime
%>

<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
${_(u'About OpenFisca')}
</%def>


<%def name="page_content()" filter="trim">
        <h3>${_(u'Copyright')}</h3>
        <p>${_(u'Copyright © {0} OpenFisca Team').format(u', '.join(
            unicode(year)
            for year in range(2011, datetime.date.today().year + 1)
            ))}</p>
        <h3>${_(u'License')}</h3>
        <a href="http://www.gnu.org/licenses/agpl.html" rel="external">${_(u'GNU Affero General Public License')}</a>
        <h3>${_(u'Source Code')}</h3>
        <a href="https://github.com/openfisca" rel="external">https://github.com/openfisca</a>

        <h3>Développeurs initiaux</h3>
        Clément Schaff et Mahdi Ben Jelloul (Centre d'analyse stratégique, puis Commissariat général à la stratégie et
        à la prospective)

        <h3>Contributeurs au code (<em>OpenFisca Team</em>)</h3>
        <ul>
            <li>Mahdi Ben Jellloul</li>
            <li>Christophe Benz</li>
            <li>Laurence Bouvard</li>
            <li>Sarah Dijols</li>
            <li>Alexis Eidelman</li>
            <li>Malka Guillot</li>
            <li>Victor Le Breton</li>
            <li>Louise Paul-Delvaux</li>
            <li>Emmanuel Raviart</li>
            <li>Jérôme Santoul</li>
            <li>Clément Schaff</li>
            <li>Romain Soufflet</li>
        </ul>

        <h3>Remerciements</h3>
        <ul>
            <li>Antoine Bozio</li>
            <li>Alain Trannoy</li>
        </ul>

        <h3>${_('Partners')}</h3>
        <%self:partners/>
</%def>

