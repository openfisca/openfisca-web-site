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
from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">Présentation</%def>


<%def name="page_content()" filter="trim">
        <h2>Qu'est-ce qu'OpenFisca</h2>

        <p>
            OpenFisca est un moteur ouvert de microsimulation du système socio-fiscal français.
            Il permet de calculer simplement un grand nombre de prestations sociales et d'impôts payés
            par les ménages, et de simuler l'impact de réformes sur leur budget.
            Il s'agit d'un outil à vocation pédagogique pour aider les citoyens à mieux comprendre le système
            socio-fiscal.
        </p>

        <p>
            Le moteur d'OpenFisca étant totalement indépendant du système socio-fiscale, il est possible de simuler
            n'importe quel pays.
        </p>

        <p>
            L'impact des modifications de la législation ou des formules peut également être calculé via des réformes.
            <a href="${urls.get_url(ctx, 'reforms')}">Examples de réformes</a>
        </p>

        <p>
            Lorsqu'il est connecté sur des données d'enquête, OpenFisca peut aussi calculer les conséquences sur le
            budget d'une réforme et son impact sur la distribution.
        </p>

        <p>
            Pour le moment le principal pays supporté est la
            <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">France</a>.
            La versions actuelle implémente un grand nombre d'impôts, de prestations sociales et d'aides au logment
            pour la France depuis les 10 dernières années.
            La <a href="https://github.com/openfisca/openfisca-tunisia" rel="external" target="_blank">Tunisie</a>
            bénéficie d'une support plus expérimental car la modélisation de son système socio-fiscal est moins
            avancée (janvier 2015).
            Mais ceci est dû uniquement à un manque de main d'œuvre pour saisir et maintenir à jour la législation
            socio-fiscale tunisienne.
        </p>

        <div class="alert alert-warning">
            <h4>Avertissement</h4>
            <p>
                OpenFisca calcule les montants des cotisations sociales, des contributions sociales, des impôts
                et des prestations en utilisant :
            </p>
            <ul>
                <li>les caractéristiques du ménage, telles que fournies par l'utilisateur</li>
                <li>un modèle <em>simplifié</em> et <em>approximatif</em> de la législation socio-fiscale</li>
            </ul>
            <p>
                Ces montants sont seulement donnés à titre indicatif et peuvent être différents de ceux déterminés
                par les différentes administrations lors de l'étude des dossiers réels.
                Les résultats ne sauraient engager l'administration, ou plus généralement n'importe quel organisme
                impliqué dans le calcul des impôts et des prestations.
            </p>
            <p>
                En effet, votre situation familiale et/ou vos ressources ou celles de l'un des membres de votre
                famille peuvent changer ou ne pas avoir été prises en compte lors de la simulation et
                certaines hypothèses simplificatrices ont été effectuées.
            </p>
        </div>

        <h2>Premiers pas</h2>

        <p>

            L'<a href="${conf['urls.ui']}">interface utilisateur web</a> permet à l'utilisateur de calculer et
            d'afficher de façon interactive tous ces impôts et prestations pour n'importe quel type de foyer,
            et de jouer avec les réformes.
        </p>

        <h2>Historique d'OpenFisca</h2>

        <p>
            Le développement d'OpenFisca a débuté en mai 2011 au
            <a href="http://www.strategie.gouv.fr/" rel="external" target="_blank">
              <abbr title="Centre d'analyse stratégique">CAS</abbr>
              (rebaptisé France Stratégie /
              <abbr title="Commissariat général à la stratégie et à la prospective">CGSP</abbr>
              en avril 2013)
            </a>
            avec le soutien de
            <a href="http://www.idep-fr.org/" rel="external" target="_blank">
                l'<abbr title="Institut d'économie publique">IDEP</abbr>
            </a>.
            Le code source a été diffusé sous une licence libre en novembre 2011.
            Initialement OpenFisca a été développé sous forme d'application de bureau
            (utilisant la librairie <a href="http://qt-project.org/" rel="external" target="_blank">Qt</a>)
            avec une API Python.
        </p>
        <p>
            Début 2014, quand <a href="https://www.etalab.gouv.fr/" rel="external" target="_blank">Etalab</a>
            s'est investi dans le développement d'OpenFisca, il a été décidé de :
        </p>
        <ul>
            <li>
                séparer le moteur du simulateur de son interface utilisateur d'application de bureau
            </li>
            <li>
                proposer une <a href="${urls.get_url(ctx, 'documentation', 'api')}">API web</a> en plus de l'API Python
                et de privilégier cette API web
            </li>
            <li>
                démontrer l'intérêt de l'API web en développant des exemples d'utilisation et notamment une
                interface web de simulation de cas personnels
            </li>
            <li>
                proposer un <em>accès public à cette API web</em>, ouvert à tous : administrations,
                chercheurs, citoyens, etc.
            </li>
        </ul>
        <p>
            Depuis cette date, le logiciel est développé intensivement par
            <a href="https://www.etalab.gouv.fr/" rel="external" target="_blank">Etalab</a>.
            Parallèlement le
            <a href="http://www.strategie.gouv.fr/" rel="external" target="_blank">
                <abbr title="Commissariat général à la stratégie et à la prospective">CGSP</abbr>
            </a>,
            appuyé par
            <a href="http://www.idep-fr.org/" rel="external" target="_blank">
                l'<abbr title="Institut d'économie publique">IDEP</abbr>
            </a>
            et
            <a href="http://www.ipp.eu/" rel="external" target="_blank">
                l'<abbr title="Institut des politiques publiques">IPP</abbr>
            </a>, améliore le modèle économique et actualise la législation socio-fiscale française.
        </p>
        <p>
            Actuellement (mars 2014), la version Qt n'est plus maintenue et seule la version web fait l'objet de
            développements.
        </p>
</%def>
