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
import datetime
import itertools
import urllib
import urlparse

import babel.dates
import lxml.html
import logging
from toolz import partition_all
from ttp import ttp
import twitter

from openfisca_web_site import conf, urls
%>


<%inherit file="/france/fr/tree/index.mako"/>


<%def name="calculette_impots_blocks()" filter="trim">
    <div class="page-header">
        <h2>"Calculette Impôts" <span class="label label-success">new</span></h2>
    </div>
    <div class="row">
        <div class="col-md-4 col-sm-6">
            <h3>Presentation</h3>
            <p class="text-justify">
                 La « Calculette Impôts » est le logiciel écrit par la <a href="http://www.economie.gouv.fr/dgfip"><abbr title="Direction générale des Finances publiques">DGFiP</abbr></a> qui calcule l'impôt sur les revenus des particuliers.
            </p>
            <p class="text-justify">
                Ce logiciel a été ouvert par l'administration en avril 2016. Il est écrit en <a href="https://git.framasoft.org/openfisca/calculette-impots-m-source-code">langage M</a> développé en interne à la DGFiP, et contient les règles de calcul de l'impôt telles que décrites dans la législation.
            </p>
            <p class="text-justify">
                L'équipe OpenFisca a d'abord réalisé une <a href="https://git.framasoft.org/openfisca/calculette-impots-python">traduction en Python</a> du code M, permettant d'exécuter des calculs sur n'importe quel ordinateur.
            </p>
            <p class="text-justify">
                Puis un <a href="https://forum.openfisca.fr/t/guide-pratique-du-hackathon-codeimpot/42">hackathon</a> célébrant cette ouverture a eu lieu début avril 2016, et a accueilli plusieurs <a href="https://forum.openfisca.fr/t/projets-du-hackathon-codeimpot/40?source_topic_id=42">ateliers</a> qui ont donné naissance à des outils gravitant autour du code M.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.forum'], '/t/acceder-au-code-source-de-la-calculette-impots/37')}" role="button">
                    Read more
                </a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6">
            <h3>Related tools</h3>
            <p class="text-justify">
                L'<a href="https://git.framasoft.org/openfisca/calculette-impots-web-api">API web</a> permet
                aux développeurs d'utiliser la Calculette Impôts depuis une application web, un article économique,
                une infographie dynamique, etc.
            </p>
            <p class="text-justify">
                Le <a href="http://calc.ir.openfisca.fr/">Web Explorer</a> de la Calculette Impôts permet de naviguer
                dans les variables du code M.
            </p>
            <p class="text-justify">
                D'autres traductions de la Calculette Impôts ont émergé du hackathon :
                en <a href="https://git.framasoft.org/openfisca/calculette-impots-m-vector-computing">Python vectoriel</a>,
                permettant notamment d'accélérer considérablement les calculs,
                et en <a href="http://calc.ir.openfisca.fr/mtojs/">JavaScript</a> afin d'effectuer les calculs
                sans disposer de connexion internet, directement depuis le navigateur ou une application mobile.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="https://forum.openfisca.fr/t/code-source-de-la-calculette-impots/37" role="button">
                    Voir tous les outils
                </a>
            </p>
        </div>
        <div class="col-md-4 col-sm-6">
            <h3>Installation</h3>
            <p class="text-justify">
                Depuis son ouverture, il est tout à fait possible d'installer la Calculette Impôts sur un ordinateur,
                tout comme chacun des outils l'accompagnant.
            </p>
            <p class="text-justify">
                Pour cela, veuillez vous référer aux fichiers <tt>README</tt> de chaque projet.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="https://forum.openfisca.fr/t/code-source-de-la-calculette-impots/37" role="button">
                    Voir tous les projets
                </a>
            </p>
        </div>
    </div>
</%def>


<%def name="community()" filter="trim">
    <div class="page-header">
        <h2>Free software and Community</h2>
    </div>
    <p class="text-justify">
        Tous les outils développés par la communauté OpenFisca sont des logiciels libres.
        Cela signifie que vous pouvez utiliser les logiciels du projet OpenFisca, les installer,
        étudier leur code source et le modifier, et le redistribuer comme bon vous semble.
        Une seule contrainte : les travaux dérivés d'OpenFisca doivent eux aussi être libres.
    </p>
    <p class="text-justify">
        Nous croyons qu'il est indispensable pour la société de disposer de modèles ouverts de calcul des impôts et
        des prestations sociales, en premier lieu pour des raisons de transparence. D'où le choix du logiciel libre.
    </p>
    <p class="text-justify">
        OpenFisca is a free project, open to all. But it is first and foremost a very ambitious project, which cannot succeede without the help of many.
    </p>
    <p class="text-justify">
        Whatever your qualifications, if you are interested in OpenFisca, you can contribute to its development.
        All people of good will are welcome.
        Que vous soyez chercheur, économiste,
        agent de l'administration publique, étudiant ou citoyen intéressé par l'ouverture des modèles.
    </p>
    <p class="text-justify">
        Les membres de la communauté ainsi que les nouveaux venus peuvent échanger sur le
        <a href="${conf['urls.forum']}" role="button">forum d'OpenFisca</a>.
    </p>
    <p class="text-justify">
        La communauté OpenFisca a déjà fourni un énorme travail de rePresentation de la législation française,
        de développement du moteur de calcul et de réalisation de produits utilisant OpenFisca,
        comme le site gouvernemental <a href="https://mes-aides.gouv.fr/">mes-aides.gouv.fr</a>.
        Voir la <a href="https://github.com/openfisca/openfisca-france#contributors">liste des contributeurs à OpenFisca-France</a>,
        le dépôt contenant la traduction en code source Python du système socio-fiscal français.
    </p>
    <p class="text-justify">
        OpenFisca has already been used for project developed during hackathons to produce new visualisations, illustrate some research, create specialized simulators, etc.
        Contact us to add your project!
    </p>
    <%self:community_elements/>
</%def>


<%def name="h1_content()" filter="trim">
Home
</%def>


<%def name="openfisca_blocks()" filter="trim">
    <div class="page-header">
        <h2>OpenFisca simulator</h2>
    </div>
    <div class="row">
        <div class="col-md-4 col-sm-6">
            <h3>Presentation</h3>
            <p class="text-justify">
                OpenFisca is an open micro-simulator of the tax-benefit system.
                It allows users to calculate many social benefits and taxes paid by households and to simulate
                the impact of reforms on their budget.
            </p>
            <p class="text-justify">
                This tool has an <em>educational purpose</em>, and aims to help citizens better understand the tax-benefit system.
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'en/index.html')}" role="button">
                    Read more
                </a>
            </p>
        </div>
        <div class="col-md-4 col-sm-6">
            <h3>Web API</h3>
            <p class="text-justify">
                The API lets you use the web OpenFisca engine, without installing it, from any web page.
            </p>
            <p class="text-justify">
                The servers made available on the Internet by <a href="http://www.etalab.gouv.fr" target="_blank">Etalab</a>
                allow you to use the API to illustrate
                a research project, an economic article, to create a dynamic infographics, etc.
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'en/openfisca-web-api/index.html')}" role="button">
                    Use the web API
                </a>
            </p>
        </div>
        <div class="col-md-4 col-sm-6">
            <h3>Installation</h3>
            <p class="text-justify">
                If the use of OpenFisca online is not enough for you, you can also install different
                OpenFisca softwares on your own computer, on servers or even in the "cloud".
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'en/install.html')}" role="button">
                    Install OpenFisca
                </a>
            </p>
        </div>
    </div>
    <%self:openfisca_elements/>
</%def>
