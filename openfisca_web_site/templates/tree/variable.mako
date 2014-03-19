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


<%def name="css()" filter="trim">
    <%parent:css/>
    <link href="${urls.get_url(ctx, u'/bower/rainbow/themes/github.css')}" media="screen" rel="stylesheet">
</%def>


<%def name="page_content()" filter="trim">
    % if node.source:
        <h2>Formule</h2>
    % else:
        <h2>Variable</h2>
    % endif

        <h3>Propriétés</h3>
        <table class="table">
            <tbody>
    % if node.info:
                <tr>
                    <th>Information</th>
                    <td>${node.info}</td>
                </tr>
    % endif
##    % if node.doc:
##                <tr>
##                    <th>Documentation</th>
##                    <td><pre>${node.doc}</pre></td>
##                </tr>
##    % endif
    % if node.comments:
                <tr>
                    <th>Commentaires</th>
                    <td><pre>${node.comments}</pre></td>
                </tr>
    % endif
    % if node.type:
                <tr>
                    <th>Type</th>
                    <td>${node.type}</td>
                </tr>
    % endif
    % if node.labels:
                <tr>
                    <th>Valeurs possibles</th>
                    <td>
                        <ol class="list-group">
        % for index, label in node.labels.iteritems():
                            <li class="list-group-item">
                                <span class="badge">${index}</span>
                                ${label}
                            </li>
        % endfor
                        </ol>
                    </td>
                </tr>
    % endif
    % if node.default is not None:
                <tr>
                    <th>Valeur par défaut</th>
                    <td><code>${node.default}</code></td>
                </tr>
    % endif
    % if node.start or node.end:
                <tr>
                    <th>Date de validité</th>
                    <td>${u' - '.join([node.start or u'...', node.end or u'...'])}</td>
                </tr>
    % endif
            </tbody>
        </table>
    % if node.source:
        % if node.parameters:

        <h3>Paramètres</h3>
        <ul>
            % for parameter in node.parameters:
            <li>
                <a href="${parameter['name']}">${parameter['name']}</a>
                % if parameter.get('label'):
                : ${parameter['label']}
                % endif
             </li>
            % endfor
        </ul>
        % endif
        % if node.source:

        <h3>Code source <a class="btn btn-info" href="https://github.com/openfisca/openfisca-france/tree/master/${
                node.module_name.replace(u'.', u'/')}.py#L${node.line_number}-${
                node.line_number + len(node.source.strip().split(u'\n')) - 1}">Voir dans GitHub</a></h3>
        <pre><code data-language="python">${node.source}</code></pre>
        % endif
    % endif
    % if node.consumers:

        <h3>Formules dépendantes</h3>
        <ul>
        % for consumer in node.consumers:
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


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/python.js')}"></script>
</%def>

