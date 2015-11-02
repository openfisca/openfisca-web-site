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
from openfisca_web_site import urls
%>


<%inherit file="/france/fr/site.mako"/>


<%def name="topbar_content()" filter="trim">
    <div class="container">
        <div class="navbar-header">
            <button class="navbar-toggle" data-target=".navbar-responsive-collapse" data-toggle="collapse" type="button">
                <span class="sr-only">${_(u'Toggle navigation')}</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${urls.get_url(ctx)}">OpenFisca</a>
        </div>
        <div class="collapse navbar-collapse navbar-responsive-collapse">
            <ul class="nav navbar-nav">
                <li><a href="${urls.get_url(ctx, 'documentation')}">Documentation</a></li>
                <li><a href="${urls.get_url(ctx, 'outils')}">Tools</a></li>
                <li><a href="${urls.get_url(ctx, 'extensions')}">Extensions</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="${urls.get_url(ctx, 'a-propos')}">About</a></li>
                <li><a href="${urls.get_url(ctx, 'contact')}">Contact</a></li>
                <%self:topbar_lang/>
            </ul>
        </div>
    </div>
</%def>
