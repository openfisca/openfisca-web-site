## -*- coding: utf-8 -*-

<%!
from openfisca_web_site import conf
from openfisca_web_site import urls
%>

<%inherit file="/page.mako"/>

<%def name="scripts()" filter="trim">
    <script src="${urls.get_static_url(ctx, u'/bower/lodash/dist/lodash.min.js')}"></script>
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
      var salary1 = 25000;
      var salary2 = 15000;

      window.addEventListener("load", callOnLoad, false);

      var updateSalaries = _.debounce(function(salary, montant) {
          if (salary == "salary1") {
            salary1 = Number(montant);
          } else if (salary == "salary2") {
            salary2 = Number(montant);
          }
          callOpenFiscaAPI();
      }, 500);


      function formatJSONOfSituation(){
        return JSON.stringify({
          "individus": {
            "Bill": {
              "salaire_de_base": {
                "2017": salary1
              },
              "revenus_du_travail": {
                "2017": null
              }
            },
            "Bob": {
              "salaire_de_base": {
                "2017": salary2
              },
              "revenus_du_travail": {
                "2017": null
              }
            }
          },
          "familles": {
            "famille_1": {
              "parents": [
                "Bill",
                "Bob"
              ],
              "prestations_sociales": {
                "2017": null
              }
            }
          },
          "foyers_fiscaux": {
            "foyer_fiscal_1": {
              "declarants": [
                "Bill",
                "Bob"
              ]
            }
          },
          "menages": {
            "menage_1": {
              "conjoint": [
                "Bob"
              ],
              "personne_de_reference": [
                "Bill"
              ],
              "impots_directs": {
                "2017": null
              },
              "revenu_disponible": {
                "2017": null
              }
            }
          }
        });
      }

      function callOnLoad(){
        var resultsOnLoad = {};
        resultsOnLoad.salaires_de_base = salary1 + salary2;
        resultsOnLoad.revenu_disponible = 29191;
        resultsOnLoad.impots_directs = 3064;
        resultsOnLoad.prestations_sociales = 0;
        resultsOnLoad.revenus_du_travail = resultsOnLoad.revenu_disponible + resultsOnLoad.impots_directs;
        resultsOnLoad.cotisations_salariales = resultsOnLoad.salaires_de_base - resultsOnLoad.revenus_du_travail;

        displayData(resultsOnLoad);
      }

      function callOpenFiscaAPI(){
        var xmlhttp = new XMLHttpRequest();
        var url = "http://localhost:5000/calculate";
        var json = formatJSONOfSituation();
        xmlhttp.open("POST", url, true);

        xmlhttp.onreadystatechange=function() {
          if (xmlhttp.readyState==4 && xmlhttp.status==200) {
            var responseFromAPI = JSON.parse(xmlhttp.responseText);
            transformData(responseFromAPI);
            }
          };
        xmlhttp.setRequestHeader("Content-Type", "application/json");
        xmlhttp.send(json);
        }


      function transformData(responseFromAPI) {
        var results = {};

        results.revenu_disponible = Math.round(responseFromAPI.menages.menage_1.revenu_disponible["2017"]);
        results.impots_directs = - Math.round(responseFromAPI.menages.menage_1.impots_directs["2017"]);
        results.revenus_du_travail = Math.round(responseFromAPI.individus.Bill.revenus_du_travail["2017"] + responseFromAPI.individus.Bob.revenus_du_travail["2017"]);
        results.prestations_sociales = Math.round(responseFromAPI.familles.famille_1.prestations_sociales["2017"]);
        results.taux_imposition = Math.round(results.impots_directs * 100 / (results.impots_directs + results.revenu_disponible));
        results.salaires_de_base = salary1 + salary2;
        results.cotisations_salariales = results.salaires_de_base - results.revenus_du_travail;
        displayData(results);
        }


      function displayData(results){
        document.getElementById("situationDescription").innerHTML=`

          <li>dispose d'un <strong>revenu disponible</strong> de ` + Math.round(results.revenu_disponible).toLocaleString("fr") + ` €/an, c'est à dire ` + (Math.round(results.revenu_disponible/12)).toLocaleString("fr") + ` €/mois ;</li>

          <li> est <strong>imposé directement</strong> à hauteur de ` + results.taux_imposition + `%( ` + results.impots_directs.toLocaleString("fr") + ` €/an, c'est à dire `+ Math.round(results.impots_directs/12).toLocaleString("fr") + ` €/mois) ;</li>

          <li>perçoit ` + results.prestations_sociales.toLocaleString("fr") + ` €/an de <strong>prestations sociales</strong>, c'est à dire ` + Math.round(results.prestations_sociales/12).toLocaleString("fr") + ` €/mois.</li>`;
          //Display du graph
          google.charts.load("current", {"packages":["treemap"]});
          google.charts.setOnLoadCallback(drawChart);


          function drawChart() {
            var data = google.visualization.arrayToDataTable([
              ["Element", "Source", "Montant", "Montant (color)"],
              ["Salaires bruts",null, results.salaires_de_base, results.salaires_de_base],
              ["Cotisations salariales", "Salaires bruts", results.cotisations_salariales, - results.cotisations_salariales],

              ["Impots directs", "Salaires bruts", results.impots_directs , - results.impots_directs],
              ["Revenu disponible", "Salaires bruts", results.revenu_disponible, results.revenu_disponible],
              ["Revenu du travail", "Revenu disponible", results.revenus_du_travail, results.revenus_du_travail],
              ["Prestations sociales", "Revenu disponible", results.prestations_sociales, results.prestations_sociales],
            ]);

            tree = new google.visualization.TreeMap(document.getElementById("chart_div"));

            tree.draw(data, {
              minColor: "#5bc0de",
              midColor: "#5bc0de",
              maxColor: "#5cb85c",
              headerHeight: 55,
              fontColor: "black",
              showScale: true
            });

          }
          document.getElementById("graph").innerHTML="<div id='chart_div' style='width: 100%; height: 400px;'></div>";

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
            <p>
            <input type="text" onkeyup=updateSalaries("salary1",this.value) size="20" value="25000"> €/an
            </p>
            <p><b>Salaire annuel brut du second conjoint :</b></p>
            <p>
            <input type="text" onkeyup=updateSalaries("salary2",this.value) size="20" value="15000"> €/an
            </p>
            <p>
            </p>
          </form>
          </div>
        <div class="col-md-8">
          <p>Ce ménage, composé de 2 adultes sans enfants, et qui ne perçoit ni pensions ni revenus du capital :</p>
          <span id="situationDescription"></span>
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

