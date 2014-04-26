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


<%def name="formula_block_content(variable, heading_level, indent)" filter="trim">

</%def>


<%def name="scripts()" filter="trim">
<script>
$(function () {
    $('#collapse-*').on('show.bs.collapse', function () {
        console.log($(this));
    });
});
</script>
</%def>


<%def name="parameters_variables()" filter="trim">
<%
    holder = node.holder
    consumers = holder.get('consumers')
    default = holder.get('default')
    end = holder.get('end')
    entity = holder.get('entity')
    formula = holder.get('formula')
    info = holder.get('info')
    labels = holder.get('labels')
    start = holder.get('start')
    survey_only = holder.get('survey_only')
    type = holder.get('@type')
%>\
    % if formula is None:
        <h2>Variable</h2>
        % if survey_only:
        <div class="alert alert-warning">
            <strong>Attention !</strong> Cette variable est utile uniquement pour les données d'enquêtes.
        </div>
        % endif
    % else:
        <h2>Formule</h2>
        % if survey_only:
        <div class="alert alert-warning">
            <strong>Attention !</strong> Cette formule est utilisée uniquement pour les données d'enquêtes.
        </div>
        % endif
    % endif

        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">Propriétés</h3>
            </div>
            <table class="table">
                <tbody>
    % if info:
                    <tr>
                        <th>Information</th>
                        <td>${info}</td>
                    </tr>
    % endif
    % if entity:
                    <tr>
                        <th>Entité</th>
                        <td>${entity}</td>
                    </tr>
    % endif
    % if type:
                    <tr>
                        <th>Type</th>
                        <td>${type}</td>
                    </tr>
    % endif
    % if labels:
                    <tr>
                        <th>Valeurs possibles</th>
                        <td>
                            <ol class="list-group">
        % for index, label in labels.iteritems():
                                <li class="list-group-item">
                                    <span class="badge">${index}</span>
                                    ${label}
                                </li>
        % endfor
                            </ol>
                        </td>
                    </tr>
    % endif
    % if default is not None:
                    <tr>
                        <th>Valeur par défaut</th>
                        <td><code>${default}</code></td>
                    </tr>
    % endif
    % if start or end:
                    <tr>
                        <th>Date de validité</th>
                        <td>${u' - '.join([start or u'...', end or u'...'])}</td>
                    </tr>
    % endif
                </tbody>
            </table>
        </div>
    % if formula is not None:
        <%self:formula_block_content formula="${formula}" heading_level="${3}" indent="${8}"/>
    % endif
    % if consumers:

        <h3>Formules dépendantes</h3>
        <ul>
        % for consumer in consumers:
            <li>
                <a href="${consumer['name']}">${consumer['name']}</a>
            % if consumer.get('label'):
                : ${consumer['label']}
            % endif
             </li>
        % endfor
        </ul>
    % endif
</%def>

