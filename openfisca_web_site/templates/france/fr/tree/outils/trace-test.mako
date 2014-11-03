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
from openfisca_web_site import conf
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Test Trace
</%def>


<%def name="page_content()" filter="trim">
    <h2>Exemple d'appel distant du traceur OpenFisca</h2>
    <form action="trace" class="form" method="POST" role="form">
        <p class="lead">
            Saisissez le JSON d'une simulation, pour connaître sa décomposition en prélèvements et prestations.
        </p>
        <div class="form-group">
            <label class="control-label" for="simulation">Simulation :</label>
            <textarea class="form-control" name="simulation" placeholder="Mettez ici la simulation au format JSON" rows="10">${u'''
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
  ],
  "variables": ["revdisp"]
}
            '''.strip()}</textarea>
        </div>
        <div class="form-group">
            <label class="control-label" for="api_url">URL API :</label>
            <input class="form-control" id="api_url" name="api_url" type="url" value="${conf['urls.api']}">
        </div>
        <button class="btn btn-primary" type="submit">Simuler</button>
    </form>
</%def>
