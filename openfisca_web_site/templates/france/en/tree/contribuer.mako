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


<%inherit file="/france/fr/tree/contribuer.mako"/>


<%def name="h1_content()" filter="trim">
Contribute to OpenFisca
</%def>


<%def name="page_content()" filter="trim">
        <h2> Why contribute to OpenFisca </h2>

        <p>
            OpenFisca is a project being developed under the GPLv3 license or later.
            The source code is freely available and modifiable.
        </p>

        <p>
      	    We encourage users to send their comments and suggestions for improvement,
      	    and to report any inaccuracy or error they might have found.
            If you want to participate more actively in its development,
            know that there are multiple ways contribute to the OpenFisca project.
        </p>

	<h2> Use the API and direct its development  </h2>
        <p>
	  <ul>
	    <li> Share your uses: you are welcome to keep us informed of the uses
	    you make of the API including visualizations you may create.
	    We'd love to be able to include them on the OpenFisca website.

	   <li> Suggest features: please tell us about the improvements
	   to the API you would like to see, so that we can make it meet your needs.

	   <li> Participate directly in the
	   <a href="https://github.com/openfisca/openfisca-web-api">
	   API's development</a>.
	  </ul>

	</p>

	<h2> Test and report errors (web API) </h2>

        <p>
	   You can contribute to the development of OpenFisca by reporting errors you would find on the calculation of benefits and taxes.
	   To enable the OpenFisca developers to solve your problems quickly, please follow these few steps:
	   <ol>
	     <li> try to create a minimal standard case that generates the error
	     <li> verify <a href="https://github.com/openfisca/openfisca-${ctx.country}/issues?state=open"> that this error is not already listed  </a> ;
	     <li> try to identify the source of the error by inspecting <a href="${urls.get_url(ctx, 'variables')}"> the formulas for the different benefits and taxes</a> ;
	     <li> report the error, possibly with additional information concerning <a href="https://github.com/openfisca/openfisca-${ctx.country}/issues?state=open">
               the page dedicated to the of collaborative development website </a>. If possible, please provide the code that allows to reproduce the error
               or the json file of the standard case you created.
	   </ol>
	</p>

	<h2> Complete the implementation of the French tax-benefit system </h2>
        <p>
            Some pieces of legislation are not yet integrated. Given the magnitude of the task, our
            ambition is to build a community of developers, economists and experts on taxes or
            social benefits to maintain and improve the software. You can help by following these steps:

	    <ol>
	      <li> identify the incomplete or missing taxes or benefits;
              <li> gather the necessary documentation to fix this issue
	      <li> propose patches that implement the incomplete or missing benefits and
	      taxes on<a href="https://github.com/openfisca/openfisca-${ctx.country}/"> collaborative development website</a>.
	    </ol>
	</p>

        <!-- <p> -->
	<!--   Compléter les paramètres de la législation LawToCode
        <!-- </p> -->


        <!-- <p> -->
	<!--   Proposer des réformes: à venir -->
        <!-- </p> -->

	<h2> Other projects linked to OpenFisca</h2>

        <p>
           You can also participate in other projects that make use of
           OpenFisca.
	   <ul>
	     <li> The development of socio-fiscal simulators is ongoging for the following countries:
	       <ul>
		 <li> <a href="https://github.com/openfisca/openfisca-france"> France </a>
		 <li> <a href="https://github.com/openfisca/openfisca-tunisia">
		   Tunisia </a>
		   ## <li> <a href="https://github.com/openfisca/openfisca-tunisia-pension">
	       </ul>
	     <li> Other projetcs built around OpenFisca (use of survey
	     data, web user interface) can be found on the
	     <a href="${urls.get_url(ctx, 'projets')}"> project
	     page</a>. The extensive list of OpenFisca related
	     projects are available on
	     <a href="https://github.com/openfisca"> the OpenFisca
	     github page</a>.
	     <li> Using OpenFisca through <a href="https://github.com/blaquans/ropenfisca"> R</a>.
	   </ul>
        </p>


</%def>
