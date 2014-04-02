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


<%def name="body_attributes()" filter="trim">
data-spy="scroll" data-target="#sommaire"
</%def>

<%def name="body_content()" filter="trim">
    <div class="container">
        <div class="row">
            <div class="col-md-9">
                <%self:breadcrumb/>
                <%self:container_content/>
            </div>
            <div class="col-md-3">
                <div id="sommaire" role="complementary">
                    <div class="hidden-print sidebar affix bs-docs-sidebar" data-offset-top="20">
                        <ul class="nav sidenav">
                            <%self:nav_content/>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%self:footer/>
</%def>
