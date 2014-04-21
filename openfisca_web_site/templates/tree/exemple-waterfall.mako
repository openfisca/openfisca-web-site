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
Exemple de waterfall
</%def>


<%def name="page_content()" filter="trim">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#waterfall-interface-tab-content" data-toggle="tab">Interface</a></li>
            <li><a href="#waterfall-template-tab-content" data-toggle="tab">Template</a></li>
            <li><a href="#waterfall-javascript-tab-content" data-toggle="tab">JavaScript</a></li>
        </ul>
        <div class="tab-content">
            <div class="tab-pane active" id="waterfall-interface-tab-content">
                <div id="waterfall-container"></div>
                <%self:waterfall_template/>
            </div>
            <div class="tab-pane" id="waterfall-template-tab-content">
                <pre><code data-language="html">${capture(self.waterfall_template)}</code></pre>
            </div>
            <div class="tab-pane fade" id="waterfall-javascript-tab-content">
                <pre><code data-language="javascript">${capture(self.waterfall_script_content)}</code></pre>
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
<%self:waterfall_script_content/>
    </script>
</%def>


<%def name="waterfall_script_content()" filter="trim">
var ln10 = Math.log(10);
var valueIndex = 0;


function calculateStepSize(range, stepsCount) {
    ## cf http://stackoverflow.com/questions/361681/algorithm-for-nice-grid-line-intervals-on-a-graph
    ## Calculate an initial guess at step size.
    var tempStepSize = range / stepsCount;

    ## Get the magnitude of the step size.
    var mag = Math.floor(Math.log(tempStepSize) / ln10);
    var magPow = Math.pow(10, mag);

    ## Calculate most significant digit of the new step size.
    var magMsd = Math.round(tempStepSize / magPow + 0.5);

    ## Promote the MSD to either 2, 5 or 10.
    if (magMsd > 5.0) {
        magMsd = 10.0;
    } else if (magMsd > 2.0) {
        magMsd = 5.0;
    } else if (magMsd > 1.0) {
        magMsd = 2.0;
    }

    return magMsd * magPow;
};


function computeBars(variableOpenedByCode, variablesTree) {
    var variableByCode = {};
    extractVariablesFromTree(variableByCode, variableOpenedByCode, variablesTree, 0, 0);
    var valueMax = 0;
    var valueMin = 0;
    for (code in variableByCode) {
        var variable = variableByCode[code];
        var value = variable.baseValue + variable.value;
        if (value > valueMax) {
            valueMax = value;
        } else if (value < valueMin) {
            valueMin = value;
        }
    }
    var tickValue = calculateStepSize(valueMax - valueMin, 8);
    valueMax = Math.round(valueMax / tickValue + 0.5) * tickValue;
    valueMin = Math.round(valueMin / tickValue - 0.5) * tickValue;
    var unitHeight = waterfallRactive.get('gridHeight') / (valueMax - valueMin);

    var bars = [];
    var y0 = waterfallRactive.get('marginTop') + (valueMax > 0 ? unitHeight * valueMax : 0);
    for (code in variableByCode) {
        var variable = variableByCode[code];
        bars.push({
            baseValue: variable.baseValue,
            height: Math.abs(variable.value) * unitHeight,
            name: variable.name,
            type: variable.type,
            value: variable.value,
            y: y0 - Math.max(variable.baseValue, variable.baseValue + variable.value) * unitHeight
        });
    }

    var yAxisLabels = [];
    for (var value = valueMin; value <= valueMax; value += tickValue) {
        yAxisLabels.push(value.toString());
    }

    waterfallRactive.set({
        bars: bars,
        tickHeight: tickValue * unitHeight,
        tickWidth: waterfallRactive.get('gridWidth') / bars.length,
        y0: y0,
        yAxisLabels: yAxisLabels
    });
}


function extractVariablesFromTree(variableByCode, variableOpenedByCode, node, baseValue, depth, hidden) {
    var children = node['children'];
    var opened = variableOpenedByCode[node.code] || depth === 0;
    if (children) {
        var childBaseValue = baseValue;
        for (var childIndex = 0; childIndex < children.length; childIndex++) {
            var child = children[childIndex];
            extractVariablesFromTree(variableByCode, variableOpenedByCode, child, childBaseValue, depth + 1,
                hidden || ! opened);
            childBaseValue += child['values'][valueIndex];
        }
    }
    value = node['values'][valueIndex];
    node.baseValue = baseValue;
    node.depth = depth;
    node.value = value;
    if (! hidden && value != 0) {
        node.type = opened && children ? 'bar' : 'var';
        variableByCode[node.code] = node;
    }
}


var waterfallRactive = new Ractive({
    computed: {
        gridHeight: function() {
            return this.get('height') - this.get('marginTop') - this.get('marginBottom');
        },
        gridWidth: function() {
            return this.get('width') - this.get('marginLeft') - this.get('marginRight');
        }
    },
    el: 'waterfall-container',
    template: '#waterfall-template',
    data: {
        bars: null,
        blueFillColor: '#80B1D3',
        blueStrokeColor: '#6B94B0',
        greenFillColor: '#B3DE69',
        greenStrokeColor: '#95B957',
        height: 400,
        marginBottom: 150,
        marginLeft: 60,
        marginRight: 20,
        marginTop: 10,
        redFillColor: '#FB8072',
        redStrokeColor: '#D26B5F',
        sali: 15000,
        tickHeight: 0,
        tickWidth: 0,
        ## The flags indicating whether a variable (with children) is closed or open (default).
        ## This is stored in a separate dictionnary, to ensure that the flag will not be lost each time the variables
        ## are updated by OpenFisca API.
        variableOpenedByCode: {},
        variablesTree: null,
        width: 590,
        y0: 0,
        yAxisLabels: null
    }
});
waterfallRactive.observe({
    'sali': function (newValue) {
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
            waterfallRactive.set('variablesTree', data['value']);
        })
        .fail(function(jqXHR, textStatus, errorThrown) {
            console.log('fail');
            console.log(jqXHR);
            console.log(textStatus);
            console.log(errorThrown);
        });
    },
    'variablesTree': function (variablesTree) {
        computeBars(this.get('variableOpenedByCode'), variablesTree);
    },
    'variableOpenedByCode': function (variableOpenedByCode) {
        computeBars(variableOpenedByCode, this.get('variablesTree'));
    }
});
waterfallRactive.on('toggle-variable', function (event) {
    var variable = this.get(event.keypath);
    this.toggle('variableOpenedByCode.' + variable.code);
});
</%def>


<%def name="waterfall_template()" filter="trim">
<script id="waterfall-template" type="text/ractive">
    <form role="form">
        <div class="form-group">
            <label for="sali">Salaire imposable</label>
            <input class="form-control" id="sali" min="0" step="1" type="number" value="{{sali}}">
        </div>
    </form>
    <div class="row">
        <div class="col-md-6">
            <svg height="{{height}}" width="{{width}}">
            {{# bars !== null}}
                ## X-axis
                <g transform="translate(0, {{y0}})">
                    <path style="fill: none; stroke: black; shape-rendering: crispedges;" d="M{{marginLeft}},6V0H{{width - marginRight}}V6"></path>
                    {{#bars:barIndex}}
                        <g transform="translate({{marginLeft + barIndex * tickWidth}}, 0)" style="opacity: 1;">
                            <line style="fill: none; stroke: black; shape-rendering: crispedges;" x2="0" y2="6"/>
                        </g>
                    {{/bars:barIndex}}
                </g>

                ## X-axis labels
                <g transform="translate(0, {{marginTop + gridHeight + 5}})">
                    {{#bars:barIndex}}
                        <g transform="translate({{marginLeft + barIndex * tickWidth + tickWidth / 2}}, 0)" style="opacity: 1;">
                            <text style="text-anchor: end; font-family: sans-serif; font-size: 10px;" dy=".71em" transform="rotate(-45)">{{name}}</text>
                        </g>
                    {{/bars:barIndex}}
                </g>

                ## Y-axis
                <g transform="translate(60, 0)">
                    <path style="fill: none; stroke: black; shape-rendering: crispedges;" d="M-6,{{marginTop}}H0V{{height - marginBottom}}H-6"></path>
                    {{#yAxisLabels:yAxisIndex}}
                        <g transform="translate(0, {{height - marginBottom - yAxisIndex * tickHeight}})" style="opacity: 1;">
                            <text style="text-anchor: end; font-family: sans-serif; font-size: 10px;" dy=".32em" x="-9" y="0">{{.}}</text>
                            <line style="fill: none; stroke: black; shape-rendering: crispedges;" y2="0" x2="-6"/>
                            <line style="fill: none; stroke: lightgray; opacity: 0.8;" y2="0" x2="{{width - marginLeft - marginRight}}"/>
                        </g>
                    {{/yAxisLabels:yAxisIndex}}
                </g>

                ## Vertical bars
                {{#bars:barIndex}}
                    {{# type === 'bar'}}
                        <rect stroke="{{blueStrokeColor}}" fill="{{blueFillColor}}" opacity="0.8" height="{{height}}" width="{{tickWidth * 0.8}}" x="{{marginLeft + barIndex * tickWidth + 0.1 * tickWidth}}" y="{{y}}"/>
                    {{/ type === 'bar'}}
                    {{# type === 'var'}}
                        <rect stroke="{{value > baseValue ? greenStrokeColor : redStrokeColor}}" fill="{{value > baseValue ? greenFillColor : redFillColor}}" opacity="0.8" height="{{height}}" width="{{tickWidth * 0.8}}" x="{{marginLeft + barIndex * tickWidth + 0.1 * tickWidth}}" y="{{y}}"/>
                    {{/ type === 'var'}}
                {{/bars:barIndex}}
            {{/ bars !== null}}
            </svg>
        </div>
        {{#variablesTree}}
            <div class="col-md-6">
                {{>childrenTree}}
                <div class="row">
                    <div class="col-md-10">
                        <span class="glyphicon glyphicon-euro" style="cursor: default"></span>
                        {{#.url}}
                            <a href="{{url}}" target="_blank">{{name}}</a>
                        {{/.url}}
                        {{^.url}}
                            {{name}}
                        {{/.url}}
                    </div>
                    <div class="col-md-2 text-right">
                        {{Math.round(value)}}
                    </div>
                </div>
            </div>
        {{/variablesTree}}
    </div>

    <!-- {{>childrenTree}} -->
    {{# .children && (variableOpenedByCode[.code] || .depth === 0)}}
        {{#children}}
            {{#.value}}
                {{# .children && variableOpenedByCode[.code]}}
                    <div class="row">
                        <div class="col-md-{{11 - depth}} col-md-offset-{{depth - 1}}">
                            <span class="glyphicon glyphicon-minus" on-click="toggle-variable" style="cursor: pointer"></span>
                            {{#.url}}
                                <a href="{{url}}" target="_blank">{{name}}</a>
                            {{/.url}}
                            {{^.url}}
                                {{name}}
                            {{/.url}}
                        </div>
                    </div>
                    {{>childrenTree}}
                {{/ .children && variableOpenedByCode[.code]}}
                {{^ .children && variableOpenedByCode[.code]}}
                    <div class="row">
                        <div class="col-md-{{11 - depth}} col-md-offset-{{depth - 1}}">
                            {{# !! .children}}
                                <span class="glyphicon glyphicon-plus" on-click="toggle-variable" style="cursor: pointer"></span>
                            {{/ !! .children}}
                            {{^.children}}
                                <span class="glyphicon glyphicon-ok" style="cursor: default"></span>
                            {{/.children}}
                            {{#.url}}
                                <a href="{{url}}" target="_blank">{{name}}</a>
                            {{/.url}}
                            {{^.url}}
                                {{name}}
                            {{/.url}}
                        </div>
                        <div class="col-md-2 text-right">
                            {{Math.round(value)}}
                        </div>
                    </div>
                {{/ .children && variableOpenedByCode[.code]}}
            {{/.value}}
        {{/children}}
    {{/ .children && (variableOpenedByCode[.code] || .depth === 0)}}
    <!-- {{/childrenTree}} -->
</script>
</%def>
