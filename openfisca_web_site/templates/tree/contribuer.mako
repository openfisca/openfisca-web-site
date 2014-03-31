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

<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Contribuer à OpenFisca
</%def>


<%def name="page_content()" filter="trim">
        <h2> Pourquoi  contribuer à OpenFisca </h2>

        <p>
            OpenFisca est un projet en cours de développement sous
            licence GPLv3 ou supérieure. Le code source est librement
            accessible et modifiable.
        </p>

        <p>
            Nous invitons les utilisateurs à nous transmettre leur
            remarques, les imprécisions ou erreurs identifiées, ainsi
            que les éventuelles propositions d’amélioration. Si vous
            voulez participer plus activement à l’évolution du
            programme, sachez qu'il est possible de contribuer de
            multiples façons au projet OpenFisca.
        </p>

	<h2> Utiliser l'API web et orienter son développement  </h2>
        <p>
	  <ul>
	    <li> Partager vos utilisations : vous êtes invités à nous
	   tenir informer des utilisations que vous faîtes de l'API et
	   notamment des visualisations que vous pourriez
	   produire. Nous serions ravis de pouvoir les recenser sur le
	   site d'OpenFisca.

	   <li> Suggérer des fonctionnalités : n'hésitez pas à nous
	   faire part des améliorations à apporter à l'API afin qu'elle
	   puisse répondre au mieux à vos besoins.

	   <li> Participer directement au
	   <a href="https://github.com/openfisca/openfisca-web-api">
	   développement de l'API</a>.
	  </ul>
	
	</p>

	<h2> Tester et rapporter les erreurs (API web) </h2>

        <p>
	   Vous pouvez contribuer au développement d'OpenFisca en
	   rapportant les erreurs sur le calcul des prestations ou des
	   impôts que vous constateriez. Afin de permettre aux
	   développeurs d'OpenFisca de résoudre les problèmes
	   rapidement, veuillez essayer de suivre la procédure
	   suivante :
	   <ol>
	     <li> essayer de réaliser un cas-type minimal permettant
	       de mettre en évidence l'erreur rencontrée
	     <li> vérifier que <a href="https://github.com/openfisca/openfisca-france/issues?state=open"> cette erreur n'est pas déjà répertoriée  </a> ;
	     <li> tenter d'identifier la source de l'erreur en
	   inspectant <a href="http://localhost:2016/variables"> les
	   formules des différents prestations et impôts</a> ;
	     <li> rapporter l'erreur accompagnée éventuellement
               d'informations complémentaires
               sur <a href="https://github.com/openfisca/openfisca-france/issues?state=open">
               la page consacrée sur le site de développement
               collaboratif</a> en fournissant si possible le code
               permettant de reproduire l'erreur ou le fichier json du
               cas type considéré.
	   </ol>         
	</p>

	<h2> Compléter l'implémentation du système socio-fiscal français </h2>
        <p>
            Certains pans de la législation ne sont pas encore
            intégrés. Étant donné l’ampleur de la tâche, notre
            ambition est de constituer une communauté de développeurs,
            d’économistes et de spécialistes de la fiscalité ou des
            prestations sociales pour maintenir et améliorer le
	    logiciel. Vous pouvez y contribuer en suivant les étapes suivantes : 

	    <ol>
	      <li> identifier les prestations ou les impôts incomplets
	      ou manquants ;
              <li> rassembler la documentation nécessaire à l'écriture
              des formules permettant de les calculer ;
	      <li> proposer les correctifs implémentant les
	      prestations et les impôts incomplets ou manquants
	      sur <a href="https://github.com/openfisca/openfisca-france/">le
	      site de développement collaboratif</a>.
	    </ol>
	</p>

        <!-- <p> -->
	<!--   Compléter les paramètres de la législation LawToCode
        <!-- </p> -->


        <!-- <p> -->
	<!--   Proposer des réformes: à venir -->
        <!-- </p> -->

	<h2> Autres projets liés à OpenFisca </h2>

        <p>
           Vous pouvez également participer à d'autres projets faisant usage d'OpenFisca. 
	   <ul>
	     <li> Le développement d'autres systèmes
	     sociaux fiscaux est : le travail est entamé pour le cas de la
	    <a href="https://github.com/openfisca/openfisca-tunisia"> Tunisie </a> 
	    <a href="https://github.com/openfisca/openfisca-tunisia-pension">
	    et les pensions tunisiennes </a>.
	     <li> Une utilisation d'OpenFisca à travers <a href="https://github.com/blaquans/ropenfisca> R</a>.	     
	   </ul>
        </p>


</%def>
