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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
API
</%def>


<%def name="page_content()" filter="trim">
        <h2>Exemple d'utilisation de l'API en Python</h2>
        Un <i>notebook IPython</i> testant différents profils avec l'API : <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/</a>

        <h2>Exemple d'utilisation de l'API en JavaScript</h2>
        <div ng-app>
            <form role="form">
                <div class="form-group">
                    <label for="sali">Revenu mensuel net du ménage</label>
                    <input class="form-control" id="sali" min="0" ng-model="sali" step="1" type="number" value="{{sali}}">
                </div>
                <div class="form-group">
                    <label for="f2ts">Patrimoine</label>
                    <input class="form-control" id="f2ts" min="0" ng-model="f2ts" step="1" type="number" value="{{f2ts}}">
                </div>
                <div class="form-group">
                    <label class="radio-inline">
                        <input type="radio" value="1"> Célibataire
                    </label>
                    <label class="radio-inline">
                        <input type="radio" value="2"> Marié
                    </label>
                </div>
                <div class="form-group">
                    <label class="radio-inline">
                        <input type="radio" value="1"> Actif
                    </label>
                    <label class="radio-inline">
                        <input type="radio" value="2"> Retraité
                    </label>
                    <label class="radio-inline">
                        <input type="radio" value="2"> Chômeur
                    </label>
                </div>
                <div class="form-group">
                    <label for="children_count">Nombre d'enfants à charge</label>
                    <input class="form-control" id="children_count" max="9" min="0" ng-model="children_count" step="1" type="number" value="{{children_count}}">
                </div>
                <p>{{sali}}</p>
                <p>{{f2ts}}</p>
                <button type="submit" class="btn btn-default">${_(u"Submit")}</button>
            </form>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/angular/angular.min.js')}"></script>
</%def>
