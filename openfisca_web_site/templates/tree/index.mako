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
from openfisca_web_site import conf
%>


<%inherit file="/index.mako"/>


<%def name="breadcrumb()" filter="trim">
</%def>


<%def name="container_content()" filter="trim">
        <%self:jumbotron/>
        <%self:partners/>
        <%self:last_articles/>
</%def>


<%def name="h1_content()" filter="trim">
${_(u'Home')}
</%def>


<%def name="jumbotron()" filter="trim">
        <div class="jumbotron">
            <div class="row">
                <div class="col-md-6">
                    <div class="carousel slide" data-ride="carousel" id="carousel" style="width: 460px; margin: 0 auto">
                        ## Indicators
                        <ol class="carousel-indicators">
                            <li data-target="#carousel" data-slide-to="0" class="active"></li>
                            <li data-target="#carousel" data-slide-to="1"></li>
                            <li data-target="#carousel" data-slide-to="2"></li>
                            <li data-target="#carousel" data-slide-to="3"></li>
                            <li data-target="#carousel" data-slide-to="4"></li>
                        </ol>
                        ## Wrapper for slides
                        <div class="carousel-inner">
                            <div class="item active">
                                <img alt="Copie d'écran OpenFisca-QT : Saisie de la composition du ménage" src="carousel/composition-menage.png">
                            </div>
                            <div class="item">
                                <img alt="Copie d'écran OpenFisca-QT : Saisie du logement" src="carousel/logement.png">
                            </div>
                            <div class="item">
                                <img alt="Copie d'écran OpenFisca-QT : Saisie des salaires" src="carousel/salaires.png">
                            </div>
                            <div class="item">
                                <img alt="Copie d'écran OpenFisca-QT : Courbe waterfall" src="carousel/waterfall.png">
                            </div>
                            <div class="item">
                                <img alt="Copie d'écran OpenFisca-QT : Courbe des barèmes" src="carousel/bareme.png">
                            </div>
                        </div>
                        ## Controls
                        <a class="carousel-control left" href="#carousel" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                        </a>
                        <a class="carousel-control right" href="#carousel" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right"></span>
                        </a>
                    </div>
                </div>
                <div class="col-md-6">
                    ## <h2>${_(u"Welcome to OpenFisca")}</h2>
                    <img alt="Logo OpenFisca" src="images/logo-openfisca.png" title="OpenFisca" />
                    <p>
                        OpenFisca est un logiciel libre de simulation du système socio-fiscal français.
                    </p>
                    <p><a class="btn btn-primary btn-lg" href="${conf['ui.url']}"role="button">${_(u"Try it online")}</a></p>
                </div>
            </div>
        </div>
</%def>


<%def name="partners()" filter="trim">
        <div class="page-header">
            <h3>${_(u"Partners")}</h3>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <a href="http://www.strategie.gouv.fr/">
                        <img alt="Logo du Commissariat général à la stratégie et à la prospective (CGSP)" src="images/logo-cgsp.png"></img>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.etalab.gouv.fr/">
                        <img alt="Logo d'Etalab" src="images/logo-etalab.png"></img>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.idep-fr.org/">
                        <img alt="Logo de l'Institut d'économie publique (IDEP)" src="images/logo-idep.png"></img>
                    </a>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.ipp.eu/">
                        <img alt="Logo de l'Institut des politiques publiques (IPP)" src="images/logo-ipp.png"></img>
                    </a>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-3">
                    <a href="http://www.strategie.gouv.fr/">
                        <h4>Commissariat général à la stratégie et à la prospective</h4>
                    </a>
                    <p>
                        Lieu d’échanges et de concertation, le Commissariat général à la stratégie et à la prospective
                        apporte son concours au Gouvernement pour la détermination des grandes orientations de l’avenir
                        de la nation et des objectifs à moyen et long termes de son développement économique, social,
                        culturel et environnemental
                    </p>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.etalab.gouv.fr/">
                        <h4>Etalab</h4>
                    </a>
                    <p>
                        Service du premier ministre chargé de l'ouverture des données publiques et du développement de
                        la plateforme française Open Data <a href="http://data.gouv.fr">data.gouv.fr</a>
                    </p>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.idep-fr.org/">
                        <h4>Institut d'économie publique</h4>
                    </a>
                    <p>
                        TODO
                    </p>
                </div>
                <div class="col-lg-3">
                    <a href="http://www.ipp.eu/">
                        <h4>Institut des politiques publiques</h4>
                    </a>
                    <p>
                        Équipe de recherche permanente dédiée à l’analyse des politiques publiques afin d'une part
                        faciliter la production de travaux universitaires à forte valeur ajoutée, d’autre part, informer
                        le débat public sur les principaux enjeux des politiques publiques au moyen d’évaluations
                        indépendantes, rigoureuses et accessibles au plus grand nombre
                    </p>
                </div>
            </div>
        </div>
</%def>


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>
