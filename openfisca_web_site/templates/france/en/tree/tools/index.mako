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


<%inherit file="/france/fr/tree/tools/index.mako"/>


<%def name="h1_content()" filter="trim">
Tools
</%def>


<%def name="page_content()" filter="trim">
    <p class="text-justify">
        To improve your understanding of OpenFisca, to enhance its tax and benefit formulas,
        to complete the legislation, etc, we develop several web tools for visualization, exploration and
        debug.
    </p>
    <p class="text-justify">
        These tools are also, in themselves, examples of use of the web API of OpenFisca.
    </p>
    <%self:tools_blocks/>
</%def>
