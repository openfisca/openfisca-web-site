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
Contribuer à OpenFisca
</%def>


<%def name="page_content()" filter="trim">
        <h2>Comment contribuer à OpenFisca</h2>

        <p>
            OpenFisca est un projet en cours de développement sous
            licence GPLv3 ou supérieure. Le code source est librement
            accessible et modifiable.
        </p>

        <p>
            Certains pans de la législation ne sont pas encore
            intégrés. Étant donné l’ampleur de la tâche, notre
            ambition est de constituer une communauté de développeurs,
            d’économistes et de spécialistes de la fiscalité ou des
            prestations sociales pour maintenir et améliorer le
	    logiciel.
        </p>

        <p>
            Nous invitons les utilisateurs à nous transmettre leur
            remarques, les imprécisions ou erreurs identifiées, ainsi
            que les éventuelles propositions d’amélioration. Si vous
            voulez participer plus activement à l’évolution du
            programme, sachez qu'il est possible de contribuer de multiples façons au
            projet OpenFisca: tester, développer le noyau et l'API, compléter
            le système socio-fiscal français ou créer un autre système
            socio-fiscal.
        </p>


        <p>
           Utiliser et aider au développement de l'API web

	   - Partager vos utilisations : vous êtes invités à nous
	   tenir informer des utilisations que vous faîtes de l'API et
	   notamment des visualisations que vous pourriez
	   produire. Nous serions ravis de pouvoir les recenser sur le
	   site d'OpenFisca.

	   - Suggérer des fonctionnalités : n'hésitez pas à nous
	   faire part des améliorations à apporter à l'API afin qu'elle
	   puisse répondre au mieux à vos besoins.

	   - Participer directement au développement de l'API
	   https://github.com/openfisca/openfisca-web-api
        
	</p>

        <p>
           Tester et rapporter les erreurs (API-web)  
	   
	   Vous pouvez contribuer au développement d'OpenFisca en
	   rapportant les erreurs sur le calcul des prestations ou des
	   impôts que vous constateriez.  Afin de permettre aux
	   développeurs d'OpenFisca de résoudre les problèmes
	   rapidement, veuillez essayer de suivre la procédure
	   suivante:
	   
	   - Essayer de réaliser un cas-type minimal permettant de
	   mettre en évidence l'erreur rencontrée
           
	   - Vérifier que cette erreur n'est pas déjà répertoriée dans
	   les "issues" github  https://github.com/openfisca/openfisca-france/issues
	   
	   - Tenter d'identifier la source de l'erreur en inspectant
	   les formules disponibles ici TODO:
           
	   - Rapporter l'erreur accompagnée éventuellement
           d'informations complémentaires en ouvrant une nouvelle
           "issue" github en fournissant si possible le code
           permettant de reproduire l'erreur ou le fichier json du cas
           type considéré.        
	</p>


        <p>
	  Compléter le microsimulateur du système socio-fiscal français
          - Identifier les prestations ou les impôts incomplets ou manquants
          - Rassembler la documentation nécessaire à l'écriture des formules permettant de les calculer
	  - Proposer les correctifs implémentant les prestations et les impôts incomplet ou manquant (voir documentation)
	</p>

        <!-- <p> -->
	<!--   Compléter les paramètres de la législation LAwToCode
        <!-- </p> -->


        <!-- <p> -->
	<!--   Proposer des réformes: à venir -->
        <!-- </p> -->

        <p>
           Vous pouvez également participer à d'autres projets faisant usage d'OpenFisca: 
	   - Une utilisation d'OpenFisca à travers R:  https://github.com/blaquans/ropenfisca
	   - Participer au développement d'autres systèmes sociaux fiscaux. Le travail est entamé pour le cas de la Tunisie 
        </p>


</%def>
