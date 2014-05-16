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
from openfisca_web_site import urls
%>


<%inherit file="/directory.mako"/>


<%def name="page_content()" filter="trim">
    <p>
        Les fichiers du hackathon OpenFisca du 14 mars 2014 concernant la proposition de réforme du quotion conjugal.
    </p>
    <p>
        Le résultat est décrit dans <a href="${urls.get_url(ctx, node.url_path, 'beamer.pdf')}">le fichier PDF
        beamer.pdf</a>.
    </p>
    <%parent:page_content/>
</%def>

