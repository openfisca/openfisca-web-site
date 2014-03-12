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
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
API
</%def>


<%def name="page_content()" filter="trim">
        <h2>Exemple d'utilisation de l'API en Python</h2>
        <i>Notebooks IPython</i> testant différents profils avec l'API : <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/</a>

        <h2>Exemple d'utilisation de l'API en JavaScript</h2>
        <h3>Cadre célibataire sans enfant</h3>
        <div id="container1"></div>
        <script id="template1" type="text/ractive">
            <form role="form">
                <div class="form-group">
                    <label for="sali">Salaire imposable</label>
                    <input class="form-control" id="sali" min="0" step="1" type="number" value="{{sali}}">
                </div>
            </form>
            <table class="table">
                <thead>
                    <tr>
                        <th>Nom</th>
                        <th>Description</th>
                        <th>Montant</th>
                    </tr>
                </thead>
                <tbody>
                    {{#columns}}
                    <tr>
                        <td>{{name}}</td>
                        <td>{{description}}</td>
                        <td>{{(value).toFixed(2)}}</td>
                    </tr>
                    {{/columns}}
                </tbody>
            </table>
        </script>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/ractive/Ractive.js')}"></script>
    <script>
var valueIndex = 0;


function extractColumnsFromTree(columns, node, baseValue) {
    var children = node['children'];
    if (children) {
        var childBaseValue = baseValue;
        for (var childIndex = 0; childIndex < children.length; childIndex++) {
            var child = children[childIndex];
            extractColumnsFromTree(columns, child, childBaseValue);
            childBaseValue += child['values'][valueIndex];
        }
    }
    value = node['values'][valueIndex];
    if (value != 0) {
        var column = {
            baseValue: baseValue,
            code: node.code,
            value: value
        };
        for (key in node) {
            column[key] = node[key];
        }
        columns.push(column);
    }
}


var ractive = new Ractive({
    el: 'container1',
    template: '#template1',
    data: {
        columns: [],
        sali: 15000
        }
});
ractive.observe('sali', function (newValue, oldValue) {
    var scenario = {
        test_case: {
            familles: [{parents: ['ind0']}],
            foyers_fiscaux: [{declarants: ['ind0']}],
            individus: [{
                activite: 'Actif occupé',
                birth: '1970-01-01',
                cadre: true,
                id: 'ind0',
                sali: parseFloat(newValue),
                statmarit: 'Célibataire'
            }],
            menages: [{personne_de_reference: 'ind0'}]
        },
        legislation_url: ${urlparse.urljoin(conf['api.url'], '/api/1/default-legislation') | n, js},
        year: 2013
    };
    $.ajax(${urlparse.urljoin(conf['api.url'], '/api/1/simulate') | n, js}, {
        contentType: 'application/json',
        data: JSON.stringify({
            scenarios: [scenario]
        }),
        dataType: 'json',
        type: 'POST',
        xhrFields: {
            withCredentials: true
        }
    })
    .done(function (data, textStatus, jqXHR) {
        var columns = [];
        extractColumnsFromTree(columns, data['value'], 0);
        ractive.set({columns: columns});
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        console.log('fail');
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
});    </script>
</%def>
