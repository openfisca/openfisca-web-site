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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">Présentation</%def>


<%def name="page_content()" filter="trim">
        <h2>Qu'est-ce qu'OpenFisca</h2>

        <p>
            OpenFisca est un moteur ouvert de microsimulation du
            système socio-fiscal tunisien. Il permet de calculer
            simplement un grand nombre de prestations sociales et
            d'impôts payés, par les ménages, et de simuler l'impact de
            réformes sur leur budget.
        </p>
        <p>
            Il s'agit d'un outil à vocation pédagogique pour aider les
            citoyens à mieux comprendre le système socio-fiscal.
        </p>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <h2 class="panel-title">Avertissement</h2>
            </div>
            <div class="panel-body">
                <p>OpenFisca calcule les montants des cotisations
                sociales, des contributions sociales, des impôts et
                des prestations à partir :</p>
                <ul>
                    <li>de caractéristiques individuelles des ménages
                    fournies par les utilisateurs</li>
                    <li>d'un modèle <strong>simplifié</strong>
                    et <strong>approximatif</strong> de la législation
                    socio-fiscale</li>
                </ul>
                <p> Ces montants sont donnés à titre indicatif et
		  peuvent être différents de ceux déterminés par les différentes
		  administrations lors de l'étude des dossiers réels. Les résultats
		  fournis ne sauraient engager l'administration fiscale ou plus
		  généralement n'importe quel organisme préleveur ou verseur sur le
		  montant définitif des impôts et des cotisations à acquitter ou des
		  prestations versées. En effet, votre situation familiale et/ou vos
		  ressources ou celles de l'un des membres de votre famille peuvent
		  changer ou ne pas avoir été prises en compte lors de la simulation et
		  certaines hypothèses simplificatrices ont été effectuées.</p>
            </div>
        </div>

        <h2>Historique d'OpenFisca</h2>

        <p>
          Le développement d'OpenFisca (version française) a débuté
	  au <abbr title="Centre d'analyse stratégique">CAS</abbr>,
	  rebaptisé <abbr title="Commissariat général à la stratégie
	  et à la prospective">CGSP</abbr> au printemps 2013, en mai
	  2011 avec le soutien de l'<abbr title="Institut d'économie
	  publique">IDEP</abbr>. Le code source a été diffusé sous une
	  licence libre en novembre 2011. Initialement OpenFisca a été
	  développé sous forme d'application bureautique intégrée (en
	  Qt) avec une API Python.
        </p>
        <p>
            Le moteur d'OpenFisca est générique. Il est donc
            totalement indépendant de la législation socio-fiscale. Il
            est donc possible de simuler n'importe quel système
            socio-fiscal. Une version tunisienne d'OpenFisca a ainsi
            été initié en paralèlle mais son développement n'est pas
            encore achevé. Toutes les bonnes volontés sont les
            bienvenues pour saisir et actualiser la législation
            socio-fiscale tunisienne.

        </p>
        <p>
            Début 2014, quand Etalab s'est investi dans le
            développement d'OpenFisca, il a été décidé de :
        </p>
        <ul>
            <li>
                séparer le moteur du simulateur de son interface
                utilisateur (en QT)
            </li>
            <li>
                proposer une <strong>API web</strong> en plus de son
                API Python et de privilégier cette API web
            </li>
            <li>
                démontrer l'intérêt de l'API web en développant des
                exemples d'utilisation et notamment une interface web
                de simulation de cas personnels
            </li>
            <li>
                proposer un <strong>accès public à cette API
                web</strong>, ouvert à tous, administrations,
                chercheurs, citoyens, etc.
            </li>
        </ul>
        <p>
            Depuis cette date, le logiciel est développé intensivement
            par Etalab. Parallèlement le <abbr title="Commissariat
            général à la stratégie et à la prospective">CGSP</abbr>,
            appuyé par l'<abbr title="Institut d'économie
            publique">IDEP</abbr> et l'<abbr title="Institut des
            politiques publiques">IPP</abbr>, améliore le modèle
            économique et actualise la législation socio-fiscale
            française.
        </p>
        <p>
            Actuellement (mars 2014), la version Qt n'est plus
            maintenue et seule la version web fait l'objet de
            développements.
        </p>

</%def>
