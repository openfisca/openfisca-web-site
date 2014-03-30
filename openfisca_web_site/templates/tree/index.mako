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

import babel.dates

from openfisca_web_site import conf, urls
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
                            <a class="btn first btn-lg" href="${urls.get_url(ctx, 'api')}">
                                <span class="glyphicon glyphicon-cog"></span> Utiliser l’API
                            </a>
                            <a class="btn second btn-lg">
                                <span class="glyphicon glyphicon-plus"></span> Ajouter une utilisation
                            </a>
                            <a class="btn btn-lg" href="${urls.get_url(ctx, 'utilisations')}">
                                <span class="glyphicon glyphicon-eye-open"></span> Découvrir les utilisations
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
                        <div class="list-group">
                            <a href="#" class="list-group-item">Présentation</a>
                            <a href="${urls.get_url(ctx, 'actualites')}" class="list-group-item">Actualités</a>
                            <a href="${urls.get_url(ctx, 'utilisations')}" class="list-group-item">Exemples d'utilisation</a>
                            <a href="${urls.get_url(ctx, 'api')}" class="list-group-item">API</a>
                            <a href="${urls.get_url(ctx, 'variables')}" class="list-group-item">Formules socio-fiscales</a>
                            <a href="${urls.get_url(ctx, 'installation')}" class="list-group-item">Installation</a>
                            <a href="https://github.com/openfisca" class="list-group-item">Code source</a>
                            <a href="#" class="list-group-item">Licence</a>
                        </div>
                        <a class="btn second btn-lg" href="${urls.get_url(ctx, 'contribuer')}">
                            <span class="glyphicon glyphicon-wrench"></span> Contribuer
                        </a>
                    </div>
                    <div class="col-md-8 slider">
<%
    visualizations_node = node.child_from_node(ctx, unique_name = 'utilisations')
    featured_visualizations = [
        visualization
        for visualization in visualizations_node.get_visualizations(ctx)
        if visualization.get('featured', False)
        ]
%>\
    % if featured_visualizations:
##                        <h3>Les meilleures utilisations</h3>
                        <div class="carousel slide" data-ride="carousel" id="carousel">
                            ## Indicators
                            <ol class="carousel-indicators">
        % for visualization in featured_visualizations:
                                <li data-target="carousel" data-slide-to="${loop.index}"${
                                        u' class="active"' if loop.first else u'' | n}></li>
        % endfor
                            </ol>
                            ## Wrapper for slides
                            <div class="carousel-inner">
        % for visualization in featured_visualizations:
                                <div class="item${u' active' if loop.first else u''}">
                                    <img alt="Copie d'écran : ${visualization['title']}" src="${visualization['thumbnail_url']}">
                                    <div class="overlay">
                                        <p><a href="${visualization['source_url']}">${visualization['title']}</a></p>
                                        <div class="info">
            % if visualization.get('logo_url') is not None:
                                            <img src="${visualization['logo_url']}">
            % endif
                                            <p>
                                                ${visualization['owner']}
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
                        <a class="voir" href="${urls.get_url(ctx, 'utilisations')}">Voir toutes les utilisations <span class="glyphicon glyphicon-chevron-right"></span></a>
    % endif
                    </div>
                </div>
            </div>
        </div>
        <div class="partners">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-sm-6">
                        <a href="http://www.strategie.gouv.fr/">
                            <img alt="Logo du Commissariat général à la stratégie et à la prospective (CGSP)" src="logos-partenaires/logo-cgsp.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <a href="http://www.etalab.gouv.fr/">
                            <img alt="Logo d'Etalab" src="logos-partenaires/logo-etalab.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <a href="http://www.idep-fr.org/">
                            <img alt="Logo de l'Institut d'économie publique (IDEP)" src="logos-partenaires/logo-idep.png"></img>
                        </a>
                    </div>
                    <div class="col-lg-3 col-sm-6">
                        <a href="http://www.ipp.eu/">
                            <img alt="Logo de l'Institut des politiques publiques (IPP)" src="logos-partenaires/logo-ipp.png"></img>
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


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>
