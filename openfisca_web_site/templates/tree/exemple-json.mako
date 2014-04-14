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
Exemples d'utilisation de l'API web
</%def>


<%def name="page_content()" filter="trim">
        <h2 id="exemple-js-cadre-celibataire">Exemple d'utilisation de L'API avec un Json</h2>

        <div>

        <div class="exemple_javascript">
            <ul id="code_javascript" class="nav nav-tabs">
                <li class="active">
                    <a href="#interface" data-toggle="tab">Interface</a>
                </li>
                <li class="">
                    <a href="#code" data-toggle="tab">Code JavaScript</a>
                </li>
            </ul>
            <div id="interface_javascript" class="tab-content">
                <div class="tab-pane fade" id="code">
                    <p>
                        <strong>Interface :</strong>
                        <pre>${capture(self.script_interface)}</pre>
                        <strong>code  :</strong>
                        <pre>${capture(self.scripts)}</pre>
                    </p>
                </div>
                <div class="tab-pane fade active in" id="interface">
                    <p>
                        <%self:script_interface/>
                    </p>
                </div>
            </div>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/ractive/Ractive.js')}"></script>
    <script src='http://cdn.ractivejs.org/latest/ractive.js'></script>
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
        jsonArea: null
    }
});

ractive.on('activate', function () {
    var jsonText = ractive.get('jsonArea');
    var simulation = JSON.parse(jsonText);
    simulation.trace = true;
    console.log('simulation', simulation);

    $.ajax(${urlparse.urljoin(conf['api.url'], '/api/1/simulate') | n, js}, {
        contentType: 'application/json',
        data: JSON.stringify(simulation),
        dataType: 'json',
        type: 'POST',
        xhrFields: {
            withCredentials: true
        }
    })
    .done(function (data, textStatus, jqXHR) {
        ractive.set({tracebacks: data.tracebacks});
    })
    .fail(function(jqXHR, textStatus, errorThrown) {
        console.log('fail');
        console.log(jqXHR);
        console.log(textStatus);
        console.log(errorThrown);
    });
});
    </script>
</%def>


<%def name="script_interface()" filter="trim">
<div id="container1">
    <script id="template1" type="text/ractive">
        <div class="form-group row">
            <p>
                <textarea name="textarea" rows="10" cols="167" value="{{jsonArea}}">Integrez le Json ici.</textarea>
            </p>
            <p>
                <div class="col-lg-5"></div>
                <button class="btn btn-primary col-lg-2" on-click="activate">OK</button>
                <div class="col-lg-5"></div>
            </p>
        </div>
        <div class="row">
            <p>
                <pre>{{JSON.stringify(tracebacks)}}</pre>
            </p>
        </div>
        <div class="row">
            <p>
                {{#tracebacks}}
                <table class="table">
                    <thead>
                        <tr>
                            <th>Nom</th>
                            <th>Libelé</th>
                            <th>Valeur</th>
                        </tr>
                    </thead>
                    <tbody>
                        {{#.:name}}
                        <tr>
                            <td>{{name}}</td>
                            <td>{{label}}</td>
                            <td>{{array}}</td>
                        </tr>
                        {{/.}}
                    </tbody>
                </table>
                {{/tracebacks}}
            </p>
        </div>
    </script>
</div>
</%def>
