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
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="css()" filter="trim">
    <%parent:css/>
    <link href="${urls.get_static_url(ctx, u'/bower/rainbow/themes/github.css')}" rel="stylesheet">
</%def>


<%def name="h1_content()" filter="trim">
Outil de trace
</%def>


<%def name="page_content()" filter="trim">
        <p>
          Cet outil présente les formules socio-fiscales intervenant dans le calcul d'un cas type,
          des valeurs de leurs paramètres et de leur résultat, dans l'ordre chronologique.
        </p>
        <div id="trace-container"></div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
<%
react_js_path = u'/bower/react/react-with-addons.js' if conf['debug'] else u'/bower/react/react-with-addons.min.js'
%>\
    <script src="${urls.get_static_url(ctx, react_js_path)}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/react/JSXTransformer.js')}"></script>
##    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
##    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
##    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/html.js')}"></script>
##    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
##    <script src="${urls.get_static_url(ctx, u'/bower/rainbow/js/language/python.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/lodash/dist/lodash.min.js')}"></script>
    <script>
<%self:simulation_script_content/>
window.apiUrl = ${api_url or conf['urls.api'] | n, js};
window.apiDocUrl = ${urls.get_url(ctx, 'api') | n, js};
window.variablesExplorerUrl = ${urls.get_url(ctx, 'outils', 'variables') | n, js};
    </script>
    <script src="${urls.get_static_url(ctx, u'/js/trace.js')}" type="text/jsx"></script>
</%def>


<%def name="simulation_script_content()" filter="trim">
window.defaultSimulationText = ${simulation_text or u'''\
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
        "individus": [
          {
            "id": "ind0",
            "sali": 15000
          },
          {
            "id": "ind1"
          }
        ],
        "menages": [
          {
            "personne_de_reference": "ind0",
            "conjoint": "ind1"
          }
        ]
      },
      "period": "2013"
    }
  ],
  "variables": ["revdisp"]
}''' | n, js};
</%def>
