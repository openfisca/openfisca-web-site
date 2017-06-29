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
from openfisca_web_site import conf
%>


<%inherit file="/page.mako"/>

<%def name="scripts()" filter="trim">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"
    integrity="sha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4="
    crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      //Variables globales
      var salaire1 = 25000
      var salaire2 = 15000
      var revenuDisponible = 0

      window.addEventListener('load', appelALAPI, false);

      // Fonctions
      function miseAjourDesSalaires(salaire, montant){
        if (salaire == "salaire1"){
          salaire1 = Number(montant);
        }else if (salaire == "salaire2"){
          salaire2 = Number(montant);
        };
        appelALAPI()
      }
      function JSONDeLaSituation(){
        var scenarioObj = {
                    scenarios: [
                      {
                        test_case: {
                          familles: [
                            {
                              parents: ["individu0", "individu1"]
                            }
                          ],
                          foyers_fiscaux: [
                            {
                              declarants: ["individu0", "individu1"],
                            }
                          ],
                          individus: [
                            {
                              date_naissance: "1980-01-01",
                              id: "individu0",
                              salaire_de_base: salaire1
                            },
                            {
                              date_naissance: "1982-01-01",
                              id: "individu1",
                              salaire_de_base: salaire2
                            }
                          ],
                          menages: [
                            {
                              personne_de_reference: "individu0",
                              conjoint:"individu1"
                            }
                          ]
                        },
                        period: "2016"
                      }
                    ],
                    variables: ["revenu_disponible"],
                    intermediate_variables: true
          }
        var scenarioString = JSON.stringify(scenarioObj)
        return scenarioString
        }
      function appelALAPI(){
        var xmlhttp = new XMLHttpRequest();
        var url = "https://api.openfisca.fr/api/1/calculate";
        var json = JSONDeLaSituation();
        xmlhttp.open("POST", url, true);

        xmlhttp.onreadystatechange=function() {
          //console.log(xmlhttp.responseText)
          if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            responseFromAPI = JSON.parse(xmlhttp.responseText);
            //console.log(responseFromAPI || xmlhttp.responseText);
            transformationDeLaDonnee(responseFromAPI);
            }
          };
        xmlhttp.setRequestHeader("Content-Type", "application/json");
        xmlhttp.send(json);
        }
      function transformationDeLaDonnee(responseFromAPI) {
        var results = {};
        results["revenu_disponible"] = Math.round(responseFromAPI.value[0].menages[0].revenu_disponible["2016"]);
        results["impots_directs"] = -Math.round((responseFromAPI.value[0].menages[0].impots_directs["2016"]));
        results["revenus_du_travail"] = 0;
        for (var individu in responseFromAPI.value[0].individus){
          results["revenus_du_travail"] += Math.round(responseFromAPI.value[0].individus[individu].revenus_du_travail["2016"]);
            }
        results["prestations_sociales"] = Math.round(responseFromAPI.value[0].familles[0].prestations_sociales["2016"]);
        results["txDImposition"] = Math.round((results["impots_directs"])*100/(results["impots_directs"] + (results["revenu_disponible"])));
        results["txDisponible"] = Math.round(100 - results["txDImposition"]);
        results["salairesBruts"] = salaire1 + salaire2;
        results["chargesSalariales"] = results["salairesBruts"] - results["revenus_du_travail"];
        affichageDeLInformation(results);
        };
      function affichageDeLInformation(results){
        document.getElementById("txtRevenuDisponible").innerHTML=`
          <li>dispose d'un <strong>revenu disponible</strong> de ` + (Math.round(results["revenu_disponible"])).toLocaleString("fr") + ` €/an, c'est à dire ` + (Math.round(results["revenu_disponible"]/12)).toLocaleString("fr") + ` €/mois ;</li>
          <li> est <strong>imposé directement</strong> à hauteur de `+ results["txDImposition"]+`%( `+results["impots_directs"].toLocaleString("fr") + ` €/an, c'est à dire `+ Math.round(results["impots_directs"]/12).toLocaleString("fr") + ` €/mois) ;</li>
          <li>perçoit `+results["prestations_sociales"].toLocaleString("fr")+ ` €/an de <strong>prestations sociales</strong>, c'est à dire `+ Math.round(results["prestations_sociales"]/12).toLocaleString("fr") + ` €/mois.</li>`;
          //Display du graph
          google.charts.load('current', {'packages':['treemap']});
          google.charts.setOnLoadCallback(drawChart);
          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ['Element', 'Source', 'Montant', 'Montant (color)'],
              ['Salaires bruts',null, results["salairesBruts"], results["salairesBruts"]],
              ['Charges salariales', 'Salaires bruts', results["chargesSalariales"], - results["chargesSalariales"]],

              ['Impots directs', 'Salaires bruts', results["impots_directs"] , - results["impots_directs"] ],
              ['Revenu disponible', 'Salaires bruts', results["revenu_disponible"],                               results["revenu_disponible"]],
              ['Revenu du travail', 'Revenu disponible', results["revenus_du_travail"],                               results["revenus_du_travail"]],
              ['Prestations sociales', 'Revenu disponible', results["prestations_sociales"], results["prestations_sociales"]],
            ]);

            tree = new google.visualization.TreeMap(document.getElementById('chart_div'));

            tree.draw(data, {
              minColor: '#5bc0de',
              midColor: '#5bc0de',
              maxColor: '#5cb85c',
              headerHeight: 55,
              fontColor: 'black',
              showScale: true
            });

          }
          document.getElementById("graph").innerHTML='<div id="chart_div" style="width: 100%; height: 400px;"></div>';

        }
    </script>
</%def>

<%def name="h1_content()" filter="trim">
Calcul du revenu disponible
</%def>


<%def name="page_content()" filter="trim">
          <p class="lead">Le revenu disponible représente l'ensembles des revenus issus du travail, des pensions, des revenus du capital et des prestations sociales, auxquelles on soustrait les impots directs du ménage.</p>

      <div class="row">
        <!-- entrée des données -->
        <div class="col-md-4">
          <form action="javascript:void(0);">
            <p><b>Salaire annuel brut du premier conjoint :</b></p>
            <p>
              <input type="text" onkeyup= miseAjourDesSalaires("salaire1",this.value) size="20" value="25000"> €/an
            </p>
            <p><b>Salaire annuel brut du second conjoint :</b></p>
            <p>
            <input type="text" onkeyup=miseAjourDesSalaires("salaire2",this.value) size="20" value="15000"> €/an
            </p>
            <p>
            </p>
          </form>
          </div>
        <div class="col-md-8">
          <p>Ce ménage, composé de 2 adultes sans enfants, et qui ne perçoit ni pensions ni revenus du capital :</p>
          <span id="txtRevenuDisponible"></span>
        </div>
      </div>
      <hr>
      <div class="row">
        <!-- entrée des données -->
        <div class="col-md-4">
        <h3>Visualisation</h3>
          <ul>
          <li>Cliquez sur "Revenu disponible" pour en voir le détail.</li>
          <li>Faites un clic-droit pour revenir à la distribution précédente.</li>
          </ul>
          </div>
       <!-- Visualisation -->
        <div class="col-md-8">
          <!-- partie sur les revenus disponibles -->
          <span id="graph"></span>
          </div>
        </div>
        <div class="row">
        <div class="col-md-12">
        <hr>
            <p>OpenFisca-France@XXXXXXXX (insérer la version)</p>
          <hr>
        </div>
        <div class="col-md-12">
        <hr>
            <p></p>
          <hr>
         </div>
      </div>
      </div>
</%def>

