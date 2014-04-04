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


<%def name="h1_content()" filter="trim">
API
</%def>


<%def name="page_content()" filter="trim">
        <h2 id="api-web">API web</h2>

        <p>L'API web OpenFisca est constituée de quelques fonctions principales :</p>
        <ul>
            <li><a href="#fields"><code>fields</code></a> retourne la liste des variables et formules socio-fiscales</li>
            <li><a href="#field"><code>field</code></a> permet de connaître le détail d'une variable ou formule</li>
            <li><a href="#default-legislation"><code>default-legislation</code></a> retourne les paramètres socio-fiscaux utilisés par défaut dans les formules</li>
            <li><a href="#simulate"><code>simulate</code></a> lance la simulation sur un cas type</li>
        </ul>
        <p>
            L'API web utilise le format JSON, aussi bien en entrée qu'en sortie et est compatible avec la plupart des langages de programmation.
        </p>
        <p>
            Chaque fonction de l'API a sa propre URL, dont le chemin prend la forme :
            <code>b<b>/api/</b><i>(integer: version)</i><b>/</b><i>(string: fonction)</i></code>.
        </p>
        <div class="alert alert-success">
            <p>
                <span class="glyphicon glyphicon-info-sign"></span> Etalab héberge et propose une version publique de cette
                API, ouverte à tous, à l'URL <code>http://api.openfisca.fr/</code>.
            </p>
            <p>
                Pour l'utiliser, il suffit d'ajouter le préfixe <code>http://api.openfisca.fr</code> devant les chemins des
                fonctions ci-dessous.
            </p>
        </div>

        <ul>
            <li>
                <h3 id="default-legislation"><code>/api/1/default-legislation</code></h3>

                <p>Retourne les paramètres socio-fiscaux utilisés par défaut dans les formules.</p>

                <h4>Paramètres de la requête</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th>Méthode</th>
                            <td><code>GET</code></td>
                        </tr>
                    </tbody>
                </table>

                <h4>Exemple d'appel</h4>
                <p>Requête :</p>
                <pre><code>${u"""
GET /api/1/default-legislation HTTP/1.1
Host: www.openfisca.fr
                 """.strip()}</code></pre>
                <p>Réponse :</p>
                <pre><code>${u"""
HTTP/1.0 200 OK
Content-Type: application/json; charset=utf-8
                """.strip()}</code></pre>

                <pre><code data-language="javascript">${u"""
{
  "@context": "http://openfisca.fr/contexts/legislation.jsonld",
  "@type": "Node",
  "from": "2006-01-01",
  "to": "2013-12-31",
  "children": {
    "al": {
      "@type": "Node",
      "description": "Allocations logement",
      "children": {
        "R1": {
          "@type": "Node",
          "description": "R1 (% du RMI)",
          "children": {
            "taux1": {
              "@type": "Parameter",
              "description": "Taux pour 1 adulte",
              "format": "rate",
              "values": [
                {
                  "from": "2002-01-01",
                  "to": "2014-12-31",
                  "value": 0.88
                }
              ]
            },
            ...
            "taux5": {
              "@type": "Parameter",
              "description": "Taux par enfants supplémentaires",
              "format": "rate",
              "values": [
                {
                  "from": "2002-01-01",
                  "to": "2014-12-31",
                  "value": 0.4
                }
              ]
            }
          }
        },
        ...
      }
    }
  }
}
                """.strip()}</code></pre>
            </li>
            <li>
                <h3 id="field"><code>/api/1/field</code></h3>

                <p>Retourne le détail d'une variable ou formule.</p>

                <h4>Paramètres de la requête</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th>Méthode</th>
                            <td><code>GET</code></td>
                        </tr>
                        <tr>
                            <th><code>context</code></th>
                            <td>Paramètre retourné tel quel dans la réponse</td>
                        </tr>
                        <tr>
                            <th><code>variable</code></th>
                            <td>Nom de la variable ou de la formule recherchée</td>
                        </tr>
                    </tbody>
                </table>

                <h4>Exemple d'appel : <small>Détail des informations sur la formule calculant le revenu disponible</small></h4>
                <p>Requête :</p>
                <pre><code>${u"""
GET /api/1/field?variable=revdisp HTTP/1.1
Host: www.openfisca.fr
                 """.strip()}</code></pre>
                <p>Réponse :</p>
                <pre><code data-language="javascript">${u"""
HTTP/1.0 200 OK
Content-Type: application/json; charset=utf-8
                """.strip()}</code></pre>

                <pre><code data-language="javascript">${u"""
{
  "apiVersion": "1.0",
  "method": "/api/1/field",
  "params": {
    "variable": "revdisp"
  },
  "url": "http://www.openfisca.fr/api/1/field?variable=revdisp",
  "value": {
    "@type": "Float",
    "default": 0,
    "entity": "menages",
    "label": "Revenu disponible du ménage",
    "name": "revdisp",
    "formula": {
      "@type": "SimpleFormula",
      "doc": "Revenu disponible - ménage\n'men'",
      "line_number": 79,
      "module": "openfisca_france.model.common",
      "parameters": [
        {
          "entity": "individus",
          "label": "Revenus du travail (salariés et non salariés)",
          "name": "rev_trav"
        },
        {
          "entity": "individus",
          "label": "Total des pensions et revenus de remplacement",
          "name": "pen"
        },
        {
          "entity": "individus",
          "label": "Revenus du patrimoine",
          "name": "rev_cap"
        },
        {
          "entity": "individus",
          "label": "ir_lps",
          "name": "ir_lps"
        },
        {
          "entity": "familles",
          "label": "Total des prestations sociales",
          "name": "psoc"
        },
        {
          "entity": "foyers_fiscaux",
          "label": "Prime pour l'emploi",
          "name": "ppe"
        },
        {
          "entity": "menages",
          "label": "Impôts sur le revenu",
          "name": "impo"
        }
      ],
      "source": "def _revdisp(self, rev_trav_holder, pen_holder, rev_cap_holder, ir_lps_holder, psoc_holder, ppe_holder, impo):\n    '''\n    Revenu disponible - ménage\n    'men'\n    '''\n    ir_lps = self.sum_by_entity(ir_lps_holder)\n    pen = self.sum_by_entity(pen_holder)\n    ppe = self.cast_from_entity_to_role(ppe_holder, role = VOUS)\n    ppe = self.sum_by_entity(ppe)\n    psoc = self.cast_from_entity_to_role(psoc_holder, role = CHEF)\n    psoc = self.sum_by_entity(psoc)\n    rev_cap = self.sum_by_entity(rev_cap_holder)\n    rev_trav = self.sum_by_entity(rev_trav_holder)\n\n    return rev_trav + pen + rev_cap + ir_lps + psoc + ppe + impo\n"
    },
    "consumers": [
      {
        "entity": "menages",
        "label": "Niveau de vie du ménage",
        "name": "nivvie"
      }
    ]
  }
}
                """.strip()}</code></pre>

                <h4>Exemple d'utilisation</h4>
                <p>L'outil de navigation dans les formules socio-fiscales utilise l'API <code>field</code> pour afficher la page de chaque variable ou formule.</p>
                <p>Par exemple : <a href="${urls.get_url(ctx, 'variables', 'revdisp')}">formule calculant le revenu disponible</a></p>
            </li>
            <li>
                <h3 id="fields"><code>/api/1/fields</code></h3>

                <p>Retourne la liste des variables et formules socio-fiscales.</p>

                <h4>Paramètres de la requête</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th>Méthode</th>
                            <td><code>GET</code></td>
                        </tr>
                        <tr>
                            <th><code>context</code></th>
                            <td>Paramètre retourné tel quel dans la réponse</td>
                        </tr>
                    </tbody>
                </table>

                <h4>Contenu de la réponse</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th><code>columns</code></th>
                            <td>
                                Contient la liste des variables d'entrée, sous forme de dictionnaire
                                <code>"<i>(code de la colonne)</i>": <i>(dictionnaire décrivant la colonne)</i></code>
                            </td>
                        </tr>
                        <tr>
                            <th><code>columns_tree</code></th>
                            <td>
                                Contient l'arborescence des codes des colonnes d'entrée. Cette arborescence permet de
                                regrouper les variables d'entrée par bloc dans l'interface utilisateur
                            </td>
                        </tr>
                        <tr>
                            <th><code>prestations</code></th>
                            <td>
                                <p>
                                    Contient la liste des formules (et donc des variables de sortie), sous forme de
                                    dictionnaire
                                    <code>"<i>(code de la prestation)</i>": <i>(dictionnaire décrivant la prestation)</i></code>
                                </p>
                                <div class="alert alert-success">
                                    <p>
                                        <strong>Note !</strong> Il est possible de fournir une valeur d'entrée à une prestation.
                                        Dans ce cas, la prestation est traitée comme une variable d'entrée et sa formule est
                                        ignorée.
                                    </p>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h4>Exemple d'appel</h4>
                <p>Requête :</p>
                <pre><code>${u"""
GET /api/1/fields HTTP/1.1
Host: www.openfisca.fr
                 """.strip()}</code></pre>
                <p>Réponse :</p>
                <pre><code>${u"""
HTTP/1.0 200 OK
Content-Type: application/json; charset=utf-8
                """.strip()}</code></pre>

                <pre><code data-language="javascript">${u"""
{
  "apiVersion": "1.0",
  "columns": {
    "cho_ld": {
      "@type": "Boolean",
      "cerfa_field": {
        "0": "1AI",
        "1": "1BI",
        "2": "1CI",
        "3": "1DI",
        "4": "1EI"
      },
      "default": false,
      "entity": "ind",
      "label": "Demandeur d'emploi inscrit depuis plus d'un an",
      "name": "cho_ld"
    },
    "sali": {
      "@type": "Integer",
      "cerfa_field": {
        "0": "1AJ",
        "1": "1BJ",
        "2": "1CJ",
        "3": "1DJ",
        "4": "1EJ"
      },
      "default": 0,
      "entity": "ind",
      "label": "Revenus d'activité imposables",
      "name": "sali",
      "val_type": "monetary"
    },
    ...
    "birth": {
      "@type": "Date",
      "default": "1970-01-01",
      "entity": "ind",
      "label": "Année de naissance",
      "name": "birth",
      "val_type": "date"
    },
    "prenom": {
      "@type": "String",
      "default": 0,
      "entity": "ind",
      "label": "Prénom",
      "name": "prenom"
    },
    ...
    "so": {
      "@type": "Enumeration",
      "default": 0,
      "entity": "men",
      "label": "Statut d'occupation",
      "name": "so",
      "labels": {
        "0": "Non renseigné",
        "1": "Accédant à la propriété",
        "2": "Propriétaire (non accédant) du logement",
        "3": "Locataire d'un logement HLM",
        "4": "Locataire ou sous-locataire d'un logement loué vide non-HLM",
        "5": "Locataire ou sous-locataire d'un logement loué meublé ou d'une chambre d'hôtel",
        "6": "Logé gratuitement par des parents, des amis ou l'employeur"
      }
    },
    ...
  },
  "columns_tree": {
    "individus": {
      "children": [
        {
          "label": "Principal",
          "children": [
            "prenom",
            "birth",
            "statmarit",
            "sali",
            "choi",
            "rsti"
          ]
        },
        {
          "label": "Traitements, salaires, primes pour l'emploi et rentes",
          "children": [
            "activite",
            ...
            "alr_decl"
          ]
        },
        {
          "label": "Auto-entrepreneur (ayant opté pour le versement libératoire)",
          "children": [
            "ebic_impv",
            "ebic_imps",
            "ebnc_impo"
          ]
        },
        {
          "label": "Revenus agricoles",
          "children": [
            "frag_exon",
            ...
            "nrag_ajag"
          ]
        },
        {
          "label": "Revenus industriels et commerciaux professionnels",
          "children": [
            "mbic_exon",
            ...
            "nbic_pvce"
          ]
        },
        {
          "label": "Revenus industriels et commerciaux non professionnels",
          "children": [
            "macc_exon",
            ...
            "nacc_pvce"
          ]
        },
        {
          "label": "Revenus non commerciaux professionnels",
          "children": [
            "mbnc_exon",
            ...
            "nbnc_pvce"
          ]
        },
        {
          "label": "Revenus non commerciaux non professionnels",
          "children": [
            "mncn_impo",
            ...
            "cncn_pvce"
          ]
        },
        {
          "label": "Autres",
          "children": [
            "inv",
            ...
            "adoption"
          ]
        }
      ]
    },
    "familles": {
      "children": [
        {
          "label": "Autres",
          "children": [
            "inactif",
            ...
            "gar_dom"
          ]
        }
      ]
    },
    "foyers_fiscaux": {
      "children": [
        {
          "label": "Principal",
          "children": [
            "jour_xyz"
          ]
        },
        {
          "label": "Situations particulières",
          "children": [
            "caseK",
            ...
            "nbptr_n_2"
          ]
        },
        {
          "label": "Traitements, salaires, primes pour l'emploi, pensions et rentes",
          "children": [
            "f1aw",
            ...
            "f1dw"
          ]
        },
        {
          "label": "Revenus des valeurs et capitaux mobiliers",
          "children": [
            "f2da",
            ...
            "f2gr"
          ]
        },
        {
          "label": "Plus-values de cession de valeurs mobilières, droits sociaux et gains assimilés",
          "children": [
            "f3vc",
            ...
            "f3vz"
          ]
        },
        {
          "label": "Revenus fonciers",
          "children": [
            "f4ba",
            ...
            "f4bl"
          ]
        },
        {
          "label": "Charges déductibles",
          "children": [
            "f6de",
            ...
            "f6fl"
          ]
        },
        {
          "label": "Charges déductibles (autres)",
          "children": [
            "f7ud",
            ...
            "f7gv"
          ]
        },
        {
          "label": "Autres imputations et divers",
          "children": [
            "f8ta",
            ...
            "mbnc_mvct"
          ]
        },
        {
          "label": "Impôt de solidarité sur la fortune",
          "children": [
            "b1ab",
            ...
            "restit_imp"
          ]
        },
        {
          "label": "Autres",
          "children": [
            "f2ck",
            ...
            "f7cc"
          ]
        }
      ]
    },
    "menages": {
      "children": [
        {
          "label": "Principal",
          "children": [
            "loyer",
            "so",
            "code_postal"
          ]
        },
        {
          "label": "Autres",
          "children": [
            "zthabm"
          ]
        }
      ]
    }
  },
  "method": "/api/1/fields",
  "params": {},
  "prestations": {
    "mhsup": {
      "@type": "Float",
      "default": 0,
      "entity": "ind",
      "label": "mhsup",
      "name": "mhsup"
    },
    "alv": {
      "@type": "Float",
      "default": 0,
      "entity": "ind",
      "label": "alv",
      "name": "alv"
    },
    "type_sal": {
      "@type": "Enumeration",
      "default": 0,
      "entity": "ind",
      "label": "Catégorie de salarié",
      "name": "type_sal",
      "labels": {
        "0": "prive_non_cadre",
        "1": "prive_cadre",
        "2": "public_titulaire_etat",
        "3": "public_titulaire_militaire",
        "4": "public_titulaire_territoriale",
        "5": "public_titulaire_hospitaliere",
        "6": "public_non_titulaire"
      }
    },
    ...
    "check_crds": {
      "@type": "Float",
      "default": 0,
      "entity": "men",
      "label": "check_crds",
      "name": "check_crds"
    }
  },
  "url": "http://api.openfisca.fr/api/1/fields"
}
                """.strip()}</code></pre>
            </li>
            <li>
                <h3 id="graph"><code>/api/1/graph</code></h3>

                <p>
                    Retourne le graphe des variables et prestations permettant de calculer la variable donnée en
                    paramètre.
                </p>

                <h4>Paramètres de la requête</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th>Méthode</th>
                            <td><code>GET</code></td>
                        </tr>
                        <tr>
                            <th><code>context</code></th>
                            <td>Paramètre retourné tel quel dans la réponse</td>
                        </tr>
                        <tr>
                            <th><code>variable</code></th>
                            <td>
                                Nom de la variable (formule) dont on veut récupérer le graphe. Par défault la variable
                                <code>revdisp</code> est utilisée.
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h4>Contenu de la réponse</h4>
                <table class="table">
                    <tbody>
                        <tr>
                            <th><code>edges</code></th>
                            <td>
                                Contient les arcs entre les différents noeuds
                            </td>
                        </tr>
                        <tr>
                            <th><code>nodes</code></th>
                            <td>
                                Contient la liste des variables et formules intervenant dans le calcul de la variable
                                demandée
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h4>Exemple d'appel</h4>
                <p>Requête :</p>
                <pre><code>${u"""
GET /api/1/graph?variable=zone_apl HTTP/1.1
Host: www.openfisca.fr
                 """.strip()}</code></pre>
                <p>Réponse :</p>
                <pre><code>${u"""
HTTP/1.0 200 OK
Content-Type: application/json; charset=utf-8
                """.strip()}</code></pre>

                <pre><code data-language="javascript">${u"""
{
  "apiVersion": "1.0",
  "edges": [
    {
      "to": "zone_apl",
      "from": "code_postal"
    }
  ],
  "method": "/api/1/graph",
  "nodes": [
    {
      "title": "Zone APL",
      "group": "menages",
      "id": "zone_apl",
      "label": "zone_apl"
    },
    {
      "title": "Code postal du lieu de résidence",
      "group": "menages",
      "id": "code_postal",
      "label": "code_postal"
    }
  ],
  "params": {
    "variable": "zone_apl"
  },
  "url": "http://api.openfisca.fr/api/1/graph?variable=zone_apl"
}
                """.strip()}</code></pre>

                <h4>Exemple d'utilisation</h4>
                <p>
                    L'<a href="${urls.get_url(ctx, 'graphe-formules')}">animation graphique de visualisation des
                    dépendances des variables et des formules socio-fiscales</a> utilise l'API <code>graph</code>.
                </p>
            </li>
            <li>
                <h3 id="simulate"><code>/api/1/simulate</code></h3>

                <p>Lance la simulation sur un cas type.</p>

                <h4>Paramètres de la requête</h4>
                <p>La requête se fait sous forme de <code>POST</code> au format JSON.</p>
                <table class="table">
                    <tbody>
                        <tr>
                            <th>Méthode</th>
                            <td><code>POST</code></td>
                        </tr>
                        <tr>
                            <th>Entêtes HTTP</th>
                            <td>
                                <ul>
                                    <li>
                                        <code>Content-Type: application/json</code>
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th><code>context</code></th>
                            <td>Paramètre retourné tel quel dans la réponse</td>
                        </tr>
                        <tr>
                            <th><code>decomposition</code></th>
                            <td>
                                Liste des variables à retourner dans la réponse. Si aucune décomposition n'est fournie,
                                la décomposition en cascade (ie "waterfall") est retournée.
                            </td>
                        </tr>
                        <tr>
                            <th><code>scenarios</code></th>
                            <td>
                                Liste des scénarios sur lesquels lancer la simulation.
                            </td>
                        </tr>
                        <tr>
                            <th><code>validate</code></th>
                            <td>
                                Booléean, faux par défaut. Quand il est vrai, la simulation n'est pas lancée et seule
                                une validation des scénarios est effectuée.
                            </td>
                        </tr>
                    </tbody>
                </table>

                <h4>Exemple d'appel</h4>
                <p>Vous trouverez ci-dessous d'autres exemples plus simples dans différents langages.</p>

                <h4>Exemples d'utilisations</h4>
                <p>
                    La plupart des <a href="${urls.get_url(ctx, 'utilisations')}">utilisations recensées</a> d'OpenFisca
                    utilisent l'API <code>simulate</code>.
                </p>
            </li>
        </ul>

        <h2 id="exemples">Exemples d'utilisation de l'API web</h2>

        <h3 id="exemples-javascript">Exemples d'utilisation de l'API en JavaScript</h3>
        <ul>
            <li><a href="graphe-formules">Graphe des dépendances des variables et des formules socio-fiscales</a></li>
            <li><a href="variables">Visualisation des variables et des formules socio-fiscales</a></li>
            <li><a href="#exemple-js-cadre-celibataire">Simulateur pour un cadre célibataire sans enfant</a></li>
        </ul>
        <h3 id="exemple-js-cadre-celibataire">Simulateur pour un cadre célibataire sans enfant</h3>
        <div id="container1"></div>
        <script id="template1" type="text/ractive">
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

        <h3 id="exemples-python">Exemples d'utilisation de l'API en Python</h3>
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

        <h3 id="exemples-r">Exemples d'utilisation de l'API en R</h3>
        <i>Notebooks IPython</i> testant différents profils avec l'API : <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/" target="_blank">http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/R/</a>

    ##    <div class="btn-group">
    ##        <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
    ##            <span class="glyphicon glyphicon-plus"></span> Autres exemples <span class="caret"></span>
    ##        </button>
    ##        <ul class="dropdown-menu" role="menu">
    ##            <li><a href="#">Exemples en R </a></li>
    ##        </ul>
    ##    </div>
</%def>


<%def name="nav_content()" filter="trim">
            <li>
                <a href="#api-web">API web</a>
                <ul class="nav">
                    <li><a href="#default-legislation"><code>default-legislation</code></a></li>
                    <li><a href="#field"><code>field</code></a></li>
                    <li><a href="#fields"><code>fields</code></a></li>
                    <li><a href="#graph"><code>graph</code></a></li>
                    <li><a href="#simulate"><code>simulate</code></a></li>
                </ul>
            </li>
            <li>
                <li>
                    <a href="#exemples">Exemples</a>
                    <ul class="nav">
                        <li><a href="#exemples-javascript">Exemples JavaScript</a></li>
                        <li><a href="#exemples-python">Exemples Python</a></li>
                        <li><a href="#exemples-r">Exemples R</a></li>
                    </ul>
                </li>
            </li>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/rainbow.min.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/generic.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/rainbow/js/language/javascript.js')}"></script>
    <script src="${urls.get_url(ctx, u'/bower/ractive/Ractive.js')}"></script>
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
        columns: [],
        sali: 15000
        }
});
ractive.observe('sali', function (newValue, oldValue) {
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
        ractive.set({columns: columns});
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
