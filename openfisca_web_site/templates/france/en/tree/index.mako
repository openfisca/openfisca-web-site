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


<%def name="container_content()" filter="trim">
    <%self:openfisca_blocks/>
    <%self:news/>
    <%self:community/>
    <%self:twitter/>
    <%self:partners/>
</%def>


<%def name="h1_content()" filter="trim">
Home
</%def>


<%def name="openfisca_blocks()" filter="trim">
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
