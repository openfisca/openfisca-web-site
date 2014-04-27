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


<%def name="css()" filter="trim">
    <%parent:css/>
    <link href="${urls.get_url(ctx, u'/bower/rainbow/themes/github.css')}" rel="stylesheet">
</%def>


<%def name="h1_content()" filter="trim">
Exemples de tableau
</%def>


<%def name="page_content()" filter="trim">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#trace-interface-tab-content" data-toggle="tab">Interface</a></li>
            <li><a href="#trace-template-tab-content" data-toggle="tab">Template</a></li>
            <li><a href="#trace-javascript-tab-content" data-toggle="tab">JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="trace-interface-tab-content">
                <div id="trace-container"></div>
                <%self:trace_template/>
            </div>
            <div class="tab-pane" id="trace-template-tab-content">
                <pre><code data-language="html">${capture(self.trace_template)}</code></pre>
            </div>
            <div class="tab-pane fade" id="trace-javascript-tab-content">
                <pre><code data-language="javascript">${capture(self.trace_script_content)}</code></pre>
            </div>
        </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/ractive/ractive.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/html.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script>
<%self:trace_script_content/>
    </script>
</%def>


<%def name="trace_script_content()" filter="trim">
var traceRactive = new Ractive({
    el: 'trace-container',
    template: '#trace-template',
    data: {
        getEntityBackgroundColor: function (step) {
            return {
                'fam': 'bg-success',
                'foy': 'bg-info',
                'ind': 'bg-primary',
                'men': 'bg-warning'
            }[step.entity] || step.entity;
        },
        getEntityKeyPlural: function (step) {
            return {
                'fam': 'familles',
                'foy': 'foyers fiscaux',
                'ind': 'individus',
                'men': 'ménages'
            }[step.entity] || step.entity;
        },
        getType: function (object) {
            return object['@type'];
        },
        showDefaultFormulas: false,
        simulationError: null,
        simulationText: ${u'''\
{
  "scenarios": [
    {
      "test_case": {
        "familles": [
          {
            "parents": ["ind0", "ind1"]
          }
        ],
        "foyers_fiscaux": [
          {
            "declarants": ["ind0", "ind1"]
          }
        ],
        "individus": {
          "ind0": {
            "sali": 15000
          },
          "ind1": {}
        },
        "menages": [
          {
            "personne_de_reference": "ind0",
            "conjoint": "ind1"
          }
        ]
      },
      "year": 2013
    }
  ] 
}''' | n, js},
        tracebacks: null,
        variableHolderByCode: {},
        variableOpenedByCode: {}
    }
});
traceRactive.on({
    'toggle-variable-panel': function (event) {
        event.original.preventDefault();
        var name = event.index.name;
        var path = 'variableOpenedByCode.' + name;
        previousValue = this.get(path);
        this.toggle(path);
        if (! this.get('variableHolderByCode')[name]) {
            $.ajax(${urlparse.urljoin(conf['api.url'], '/api/1/field') | n, js}, {
                data: {
                    variable: name
                },
                dataType: 'json',
                type: 'GET',
                xhrFields: {
                    withCredentials: true
                }
            })
            .done(function (data, textStatus, jqXHR) {
                traceRactive.set('variableHolderByCode.' + name, data.value);
            })
            .fail(function(jqXHR, textStatus, errorThrown) {
                console.log('fail');
                console.log(jqXHR);
                console.log(textStatus);
                console.log(errorThrown);
            });
        }
    },
    'submit-form': function (event) {
        if (event) {
            event.original.preventDefault();
        }
        var simulationText = this.get('simulationText');
        try {
            var simulationJson = JSON.parse(simulationText);
            simulationJson.trace = true;
        } catch (error) {
            traceRactive.set('simulationError', error.message);
            return;
        }

        $.ajax(${urlparse.urljoin(conf['api.url'], '/api/1/simulate') | n, js}, {
            contentType: 'application/json',
            data: JSON.stringify(simulationJson),
            dataType: 'json',
            type: 'POST',
            xhrFields: {
                withCredentials: true
            }
        })
        .done(function (data, textStatus, jqXHR) {
            traceRactive.set({
                simulationError: null,
                tracebacks: data.tracebacks
            });
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.log('fail');
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
            traceRactive.set('simulationError', jqXHR.responseText);
        });
    }
});

traceRactive.fire('submit-form');
</script>
</%def>


<%def name="trace_template()" filter="trim">
<script id="trace-template" type="text/ractive">
    <h2>Historique des calculs permettant de calculer le revenu disponible</h2>
    <form class="form" role="form" on-submit="submit-form">
        <p class="lead">
            Saisissez le JSON d'une simulation, pour connaître sa décomposition en prélèvements et prestations.
        </p>
        <div class="form-group">
            <label class="control-label" for="simulation">Simulation :</label>
            <textarea class="form-control" placeholder="Mettez ici la simulation au format JSON" rows="10" value="{{
                    simulationText}}"></textarea>
            {{#simulationError}}
                <pre><code data-language="javascript">{{simulationError}}</pre>
            {{/simulationError}}
        </div>
        <button class="btn btn-primary" type="submit">Simuler</button>
        <div class="checkbox">
            <label>
                <input checked="{{showDefaultFormulas}}" type="checkbox">
                Afficher aussi les formules appelées avec les valeurs par défaut
            </label>
        </div>
    </form>
    {{#tracebacks:tracebackIndex}}
        {{#.:name}}
            {{# showDefaultFormulas || ! .default_arguments}}
                <div class="panel panel-default" on-click="toggle-variable-panel">
                    <div class="panel-heading" style="cursor: pointer">
                        <div class="row">
                            <div class="col-sm-3">
                                <span class="glyphicon {{variableOpenedByCode[name] ? 'glyphicon-minus'
                                        : 'glyphicon-plus'}}"></span>
                                <code>{{name}}</code>
                            </div>
                            <div class="col-sm-6">{{label}}</div>
                            <div class="col-sm-1 {{getEntityBackgroundColor(.)}}">{{getEntityKeyPlural(.)}}</div>
                            <div class="col-sm-2">
                                {{#array}}
                                    <div class="text-right">{{.}}</div>
                                {{/array}}
                            </div>
                        </div>
                    </div>
                    {{#variableOpenedByCode[name]}}
                        <div class="panel-body">
                            {{#variableHolderByCode[name]}}
                                {{#.formula}}
                                    {{>formulaContent}}
                                {{/.formula}}
                            {{#variableHolderByCode[name]}}
                        </div>
                    {{/variableOpenedByCode[name]}}
                </div>
            {{/ showDefaultFormulas || ! .default_arguments}}
        {{/.}}
    {{/tracebacks}}


    <!-- {{>formulaContent}} -->
    {{# getType(.) === 'AlternativeFormula'}}
        <h3>Choix de fonctions <small>{{@type}}</small></h3>
        <ul>
            {{#.alternative_formulas}}
                <li>
                    {{>formulaContent}}
                </li>
            {{/.alternative_formulas}}
        </ul>
    {{/ getType(.) === 'AlternativeFormula'}}
    {{# getType(.) === 'DatedFormula'}}
        <h3>Fonctions datées <small>{{@type}}</small></h3>
        <ul>
            {{#.dated_formulas}}
                <li>
                    <span class="lead">{{start}} - {{end}}</span>
                    {{#.formula}}
                        {{>formulaContent}}
                    {{/.formula}}
                </li>
            {{/.dated_formulas}}
        </ul>
    {{/ getType(.) === 'DatedFormula'}}
    {{# getType(.) === 'SelectFormula'}}
        <h3>Choix de fonctions <small>{{@type}}</small></h3>
        <ul>
            {{#.formula_by_main_variable:mainVariable}}
                <li>
                    <span class="lead">{{mainVariable}}</span>
                    {{>formulaContent}}
                </li>
            {{/.formula_by_main_variable:mainVariable}}
        </ul>
    {{/ getType(.) === 'SelectFormula'}}
    {{# getType(.) === 'SimpleFormula'}}
        <h3>Fonction <small>{{@type}}</small></h3>
        <h4>Paramètres</h4>
        <ul>
            {{#.parameters}}
                <li>
                    {{.name}}
                    {{#.label}}« <i>{{label}}</i> »{{/.label}}
                    =
                    <ul class="list-inline" style="display: inline">
                        {{#tracebacks[tracebackIndex][.name].array}}
                            <li class="text-right">{{.}}</li>
                        {{/tracebacks[tracebackIndex][.name].array}}
                    </ul>
                </li>
            {{/.parameters}}
        </ul>
        <h4>Code source</h4>
        <pre><code data-language="python">{{source}}</code></pre>
    {{/ getType(.) === 'SimpleFormula'}}
    <!-- {{/formulaContent}} -->
</script>
</%def>

