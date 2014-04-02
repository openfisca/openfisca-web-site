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


<%def name="h1_content()" filter="trim">
Premier hackathon OpenFisca<small> le 14 mars 2014 chez Simplon.co</small>
</%def>


<%def name="page_content()" filter="trim">
        <p>Etalab en partenariat avec le CGSP et l'IPP organise un hackathon consacré au projet OpenFisca.</p>

        <h4>Présentation d'OpenFisca</h4>

        <p>OpenFisca est un logiciel libre de simulation du système socio-fiscal. Il permet de calculer un grand nombre d'impôts, de taxes, de prestations sociales et de minima sociaux, payés ou reçus par les ménages. Il est à la fois :</p>
        <ul>
            <li>Un service en ligne utilisant ce logiciel et permettant aux français de simuler leur situation. Il s’agit d’un outil à vocation pédagogique pour aider les citoyens à mieux comprendre le système socio-fiscal.</li>
            <li>Une API permettant à tout site internet (blog, journal en ligne, article scientifique, etc.) de proposer simplement des simulations, infographies, cas types, etc, insérées dans leurs propres pages web.</li>
            <li>Un outil de modélisation performant :
                <ul>
                    <li>capable de simuler aussi bien sur des cas individuels que des données d'enquêtes portant sur des dizaines de milliers de ménages</li>
                    <li>adaptable aux différentes législations des systèmes socio-fiscaux nationaux (une version pour la Tunisie est en cours de développement)</li>
                    <li>permettant de simuler l’impact de réformes sur le revenu disponible des ménages</li>
                </ul>
            </li>
        </ul>

        <p>OpenFisca est encore en pleine phase de développement.</p>

        <h4>Objectif du hackathon</h4>

        <p>
            Ce hackathon constitue la première étape d'ouverture du projet, dans le but de constituer le premier cercle d'une communauté bienveillante. Ses objectifs sont :
        </p>
        <ul>
            <li>Utiliser l'API OpenFisca pour réaliser de nouvelles infographies et les mettre en valeur</li>
            <li>Imaginer des réformes socio-fiscales et les intégrer au logiciel Openfisca</li>
            <li>S'intéresser à de nouveaux pans de la législation pour continuer à développer OpenFisca</li>
        </ul>

        <p>Le hackathon aura lieu le 14 mars 2014 à Montreuil chez Simplon.co. Il s'adresse principalement aux chercheurs en sciences sociales (économistes, sociologues, etc), journalistes, développeurs et infographistes, mais toutes les bonnes volontés intéressées pas la modélisation socio-fiscale sont les bienvenues.</p>
        <p>L'objectif est que tous les participants contribuent à un projet durant la journée.</p>
        <p>Venez avec votre ordinateur. Nous fournissons tables, chaises, accès wifi, boisson et nourriture.</p>

        <h4>Planning</h4>

        <ul>
            <li><b>10h :</b> Présentation rapide du projet et du logiciel</li>
            <li><b>10h15 :</b> Présentation de l'API</li>
            <li><b>10h30 :</b> Proposition d'ateliers par les participants</li>
            <li><b>10h45 :</b> Répartition dans les différents ateliers</li>
            <li><b>11h :</b> Au boulot</li>
            <li><b>Déjeuner :</b> Paniers repas livrés par « food truck »</li>
            <li><b>17h :</b> Restitution des différents ateliers et mise en ligne des résultats</li>
            <li><b>18h :</b> Dispersion</li>
        </ul>

        <h4>Exemples d'ateliers possibles</h4>

        <ul>
            <li>Étude de l'impact financier des unions et désunions</li>
            <li>Étude de l'impact financier de l'arrivée d'un enfant ou de son détachement du foyer fiscal</li>
            <li>Visualisation de l'impact d'une réforme sur le revenu disponible selon la composition du ménage et son niveau de vie</li>
        </ul>
</%def>
