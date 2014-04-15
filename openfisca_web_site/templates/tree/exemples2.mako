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


<%inherit file="/page-avec-nav.mako"/>


<%def name="block_decomposition()" filter="trim">
    <div id="decomposition-container"></div>
    <script id="decomposition-template" type="text/ractive">
        <div class="form-group row">
            <div>
                <textarea name="textarea" rows="10" cols="121" value="{{jsonArea}}">Integrez le Json ici.</textarea>
            </div>
            <div>
                <div class="col-lg-5"></div>
                <button class="btn btn-primary col-lg-2" on-click="activate">OK</button>
                <div class="col-lg-5"></div>
            </div>
        </div>
        <div class="row">
            <p>Afficher le Json sous forme de String <input type="checkbox" onclick="affCache('div1');" value=""/></p>
            <pre id="div1" style="display:none;">{{JSON.stringify(tracebacks)}}</pre>
        </div>
        <div class="row">
            {{#tracebacks}}
                {{#.:name}}
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading row">
                        <div class="col-md-4"><a data-toggle="collapse" data-parent="#accordion" href="#collapse-{{name}}">{{name}}</a></div>
                        <div class="col-md-4">{{array}}</div>
                        <div class="col-md-4">{{label}}</div>
                    </div>
                    <div id="collapse-{{name}}" class="panel-collapse collapse">
                        <div class="panel-body">
                            HELLO
                        </div>
                    </div>
                </div>
            </div>
                    {{/.}}
            {{/tracebacks}}
        </div>
    </script>
</%def>


<%def name="block_simulation()" filter="trim">
    <div id="simulation-container"></div>
    <script id="simulation-template" type="text/ractive">
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
                    <th>Montant</th>
                </tr>
            </thead>
            <tbody>
                {{#columns}}
                <tr>
                    <td>{{name}}</td>
                    <td>{{(value).toFixed(2)}}</td>
                </tr>
                {{/columns}}
            </tbody>
        </table>
    </script>
</%def>


<%def name="h1_content()" filter="trim">
Exemples d'utilisation de l'API web
</%def>


<%def name="page_content()" filter="trim">
<div role="main">
    <h2 id="exemples-javascript">Exemples d'utilisation de l'API en JavaScript</h2>
    <ul>
        <li><a href="graphe-formules">Graphe des dépendances des variables et des formules socio-fiscales</a></li>
        <li><a href="variables">Visualisation des variables et des formules socio-fiscales</a></li>
    </ul>

    <h3 id="exemple-simulation">Simulation</h3>
    <div class="simulation">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#interface-simulation" data-toggle="tab">Interface</a></li>
            <li><a href="#code-simulation" data-toggle="tab">Code JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade" id="code-simulation">
                <p>
                    <strong>Interface :</strong>
                    <pre>${capture(self.block_simulation)}</pre>
                    <strong>code  :</strong>
                    <pre>${capture(self.script_simulation)}</pre>
                </p>
            </div>
            <div class="tab-pane fade active in" id="interface-simulation">
                <p>
                    <%self:block_simulation/>
                </p>
            </div>
        </div>
    </div>
    
    <h3 id="exemple-decomposition">Décomposition de Simulation</h3>
    <div class="decomposition">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#interface-decomposition" data-toggle="tab">Interface</a></li>
            <li><a href="#code-decomposition" data-toggle="tab">Code JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane fade" id="code-decomposition">
                <p>
                    <strong>Interface :</strong>
                    <pre>${capture(self.block_decomposition)}</pre>
                    <strong>code  :</strong>
                    <pre>${capture(self.script_decomposition)}</pre>
                </p>
            </div>
            <div class="tab-pane fade active in" id="interface-decomposition">
                <p>
                    <%self:block_decomposition/>
                </p>
            </div>
        </div>
    </div>

    <h2 id="exemples-python">Exemples d'utilisation de l'API en Python</h2>
    <i>Notebooks IPython</i> testant différents profils avec l'API :
        <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/</a>
    <p>
    </p>
    <div class="btn-group">
        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
            <span class="glyphicon glyphicon-plus"></span> Autres exemples <span class="caret"></span>
        </button>
        <ul class="dropdown-menu" role="menu">
            <li><a href="http://nbviewer.ipython.org/github/stanislasrybak/openfisca-web-notebook-tests/tree/master/" target="_blank">Exemples en Python - Stanislas Rybak</a></li>
        </ul>
    </div>

    <h2 id="exemples-r">Exemples d'utilisation de l'API en R</h2>
    <i>Notebooks IPython</i> testant différents profils avec l'API : <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/</a>

##    <div class="btn-group">
##        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
##            <span class="glyphicon glyphicon-plus"></span> Autres exemples <span class="caret"></span>
##        </button>
##        <ul class="dropdown-menu" role="menu">
##            <li><a href="#">Exemples en R </a></li>
##        </ul>
##    </div>
</div>
</%def>


<%def name="nav_content()" filter="trim">
    <li class="active">
        <a href="#exemples-javascript">Exemples JavaScript</a>
        <ul class="nav">
            <li>
                <a href="#exemple-simulation">Simulation</a>
            </li>
            <li>
                <a href="#exemple-decomposition">Décomposition de Simulation</a>
            </li>
        </ul>
        <a href="#exemples-python">Exemples Python</a>
        <a href="#exemples-r">Exemples R</a>
    </li>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/ractive/ractive.js')}"></script>
    <%self:script_simulation/>
    <%self:script_decomposition/>
</%def>


<%def name="script_decomposition()" filter="trim">
<script>
function affCache(idDiv) {
    var div = document.getElementById(idDiv);
    if (div.style.display  == "")
        div.style.display  = "none";
    else
        div.style.display  = "";
}

var decompositionRactive = new Ractive({
    el: 'decomposition-container',
    template: '#decomposition-template',
    data: {
        jsonArea: null
    }
});
decompositionRactive.on('activate', function () {
    var jsonText = decompositionRactive.get('jsonArea');
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
        decompositionRactive.set({tracebacks: data.tracebacks});
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


<%def name="script_simulation()" filter="trim">
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


var simulationRactive = new Ractive({
    el: 'simulation-container',
    template: '#simulation-template',
    data: {
        columns: [],
        sali: 15000
        }
});
simulationRactive.observe('sali', function (newValue, oldValue) {
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
        simulationRactive.set({columns: columns});
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
