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


<%inherit file="/atom.mako"/>


<%def name="feed_author()" filter="trim">
    <author>
        <name>OpenFisca</name>
        <email>contact@openfisca.fr</email>
        <uri>http://www.openfisca.fr/</uri>
    </author>
</%def>


<%def name="feed_rights()" filter="trim">
    <link rel="license" type="application/rdf+xml" href="http://creativecommons.org/licenses/by-sa/4.0/rdf" />
    <rights>
        Copyright © ${u', '.join(
            unicode(year)
            for year in range(2011, datetime.date.today().year + 1)
            )} OpenFisca Team.
        Tous les articles de ce site, ainsi que ce flux d'actualité, sont diffusés sous licence
        http://creativecommons.org/licenses/by-sa/4.0/.
    </rights>
</%def>
