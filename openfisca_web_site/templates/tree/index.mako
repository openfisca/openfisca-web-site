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
import datetime
import json
import urllib2
import urlparse

import babel.dates

from openfisca_web_site import conf
%>


<%inherit file="/index.mako"/>


<%def name="body_content()" filter="trim">
        <div class="intro">
            <div class="container">
                <div class="row">
                    <div class="col-md-6">
                        <a class="logo" href="/">Open Fisca</a>
                    </div>
                    <div class="col-md-6">
                        <div class="buttons">
                            <a class="btn first btn-lg">
                                <span class="glyphicon glyphicon-cog"></span> utiliser l’api
                            </a>
                            <a class="btn second btn-lg">
                                <span class="glyphicon glyphicon-plus"></span> poster une réutilisation
                            </a>
                            <a class="btn btn-lg">
                                <span class="glyphicon glyphicon-eye-open"></span> Découvrir les réutilisations
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="home-boxes">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 telechar">
                        <h3>Téléchargement</h3>
                        <img src="images/telechar.png">
                        <a class="btn second btn-lg">
                            <span class="glyphicon glyphicon-download"></span> télécharger
                        </a>
                    </div>
                    <div class="col-md-8 slider">
<%
    response = urllib2.urlopen(urlparse.urljoin(conf['ui.url'], 'api/1/visualizations/search?featured=1'))
    visualizations = json.loads(response.read())
%>\
    % if visualizations:
                        <h3>Les meilleures réutilisations</h3>
                        <div class="carousel slide" data-ride="carousel" id="carousel">
                            ## Indicators
                            <ol class="carousel-indicators">
        % for visualization in visualizations:
                                <li data-target="#carousel" data-slide-to="${loop.index}"${
                                        u' class="active"' if loop.first else u'' | n}></li>
        % endfor
                            </ol>
                            ## Wrapper for slides
                            <div class="carousel-inner">
        % for visualization in visualizations:
                                <div class="item${u' active' if loop.first else u''}">
                                    <img alt="Copie d'écran : ${visualization['title']}" src="${visualization['thumbnailUrl']}">
                                    <div class="overlay">
                                        <p>${visualization['title']}</p>
                                        <div class="info">
##                                            <img src="${visualization['thumbnailUrl']}">
                                            <p>
                                                <a href="${visualization['sourceUrl']}">${visualization['url']}</a>
                                                <br>
                                                ${babel.dates.format_date(
                                                    datetime.date(*[
                                                        int(number)
                                                        for number in visualization['updated'].split('T')[0].split('-')
                                                        ]),
                                                    format = 'short',
                                                    )}
                                            </p>
                                        </div>
                                    </div>
                                </div>
        % endfor
                            </div>
                            <a class="carousel-control left" href="index.html#carousel" data-slide="prev">
                                <span class="glyphicon glyphicon-chevron-left"></span>
                            </a>
                            <a class="carousel-control right" href="index.html#carousel" data-slide="next">
                                <span class="glyphicon glyphicon-chevron-right"></span>
                            </a>
                        </div>
    % endif
                        <a class="voir" href="#">Voir toutes les réutilisations <span class="glyphicon glyphicon-chevron-right"></span></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="partners">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-6 col-xs-6">
                        <a href="http://www.strategie.gouv.fr/">
                            <img alt="Logo du Commissariat général à la stratégie et à la prospective (CGSP)" src="images/logo-cgsp.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-6 col-xs-6 ">
                        <a href="http://www.etalab.gouv.fr/">
                            <img alt="Logo d'Etalab" src="images/logo-etalab.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-6 col-xs-6">
                        <a href="http://www.idep-fr.org/">
                            <img alt="Logo de l'Institut d'économie publique (IDEP)" src="images/logo-idep.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-md-6 col-xs-6">
                        <a href="http://www.ipp.eu/">
                            <img alt="Logo de l'Institut des politiques publiques (IPP)" src="images/logo-ipp.png"></img>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <%self:footer/>
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


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>
