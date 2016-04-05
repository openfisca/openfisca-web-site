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
from openfisca_web_site import conf
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Contact
</%def>


<%def name="page_content()" filter="trim">
    <p>Pour contacter l'équipe OpenFisca :</p>
    <ul>
        <li>par courriel : <a href="mailto:contact@openfisca.fr">contact@openfisca.fr</a></li>
        <li>par Twitter : <a href="https://twitter.com/OpenFisca">@OpenFisca</a></li>
        <li>sur le <a href="${conf['urls.forum']}">forum</a> s'il s'agit d'une question ouverte</li>
        <li>ou bien, pour les développeurs, s'il s'agit d'un problème avec un logiciel en particulier, ouvrez une "issue" sur <a href="https://github.com/openfisca/">GitHub</a>
    </ul>
</%def>
