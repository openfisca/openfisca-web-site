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


<%inherit file="/france/fr/tree/exemples/tableau.mako"/>


<%def name="h1_content()" filter="trim">
Exemple de tableau
</%def>


<%def name="scenario_script_content()" filter="trim">
var baseScenario = {
    test_case: {
        foyers_fiscaux: [{declarants: ['ind0']}],
        individus: [{
            birth: '1970-01-01',
            id: 'ind0',
            sali: 0,
        }],
        menages: [{personne_de_reference: 'ind0'}]
    },
    year: 2011
};
</%def>


<%!
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="array_script_content()" filter="trim">
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


var arrayRactive = new Ractive({
    el: 'array-container',
    template: '#array-template',
    data: {
        columns: [],
        sali: 15000
        }
});
arrayRactive.observe('sali', function (newValue, oldValue) {
    var scenario = {
        test_case: {
            foyers_fiscaux: [{declarants: ['ind0']}],
            individus: [{
                birth: '1970-01-01',
                id: 'ind0',
                sali: parseFloat(newValue),
            }],
            menages: [{personne_de_reference: 'ind0'}]
        },
        legislation_url: ${urlparse.urljoin(conf['urls.api'], '/api/1/default-legislation') | n, js},
        year: 2011
    };
    $.ajax(${urlparse.urljoin(conf['urls.api'], '/api/1/simulate') | n, js}, {
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
        arrayRactive.set({columns: columns});
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        console.log('fail');
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
});
</%def>


<%def name="array_template()" filter="trim">
<script id="array-template" type="text/ractive">
    <h2>Décomposition en tableau du revenu disponible</h2>
    <form class="form-horizontal" role="form">
        <p class="lead">Indiquez votre salaire imposable, pour connaître la décomposition de votre revenu.</p>
        <div class="form-group">
            <label class="col-sm-2 control-label" for="sali">Salaire imposable :</label>
            <div class="col-sm-2">
                <input class="form-control" id="sali" min="0" step="1" type="number" value="{{sali}}">
            </div>
        </div>
    </form>
    <table class="table">
        <thead>
            <tr>
                <th>Nom</th>
                <th>Montant</th>
            </tr>
        </thead>
        <tbody>
            {{#columns}}
                <tr>
                    <td>
                        {{name}}
                        {{#.url}}
                            <a class="btn btn-default btn-xs" href="{{url}}" target="_blank" title="Explication sur {{name}}">?</a>
                        {{/.url}}
                    </td>
                    <td class="text-right">{{Math.round(value)}}</td>
                </tr>
            {{/columns}}
        </tbody>
    </table>
</script>
</%def>


<%def name="css()" filter="trim">
    <%parent:css/>
    <link href="${urls.get_static_url(ctx, u'/bower/rainbow/themes/github.css')}" rel="stylesheet">
</%def>


<%def name="h1_content()" filter="trim">
Exemple de tableau
</%def>


<%def name="page_content()" filter="trim">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#array-interface-tab-content" data-toggle="tab">Interface</a></li>
            <li><a href="#array-template-tab-content" data-toggle="tab">Template</a></li>
            <li><a href="#array-javascript-tab-content" data-toggle="tab">JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="array-interface-tab-content">
                <div id="array-container"></div>
                <%self:array_template/>
            </div>
            <div class="tab-pane" id="array-template-tab-content">
                <pre><code data-language="html">${capture(self.array_template)}</code></pre>
            </div>
            <div class="tab-pane fade" id="array-javascript-tab-content">
                <pre><code data-language="javascript">${capture(self.array_script_content)}</code></pre>
            </div>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_static_url(ctx, u'/bower/ractive/ractive.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/html.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script>
<%self:array_script_content/>
    </script>
</%def>
