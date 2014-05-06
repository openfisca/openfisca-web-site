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
import itertools

import babel.dates
import lxml.html

from openfisca_web_site import conf, urls
%>


<%inherit file="/index.mako"/>


<%def name="body_content()" filter="trim">
    <div class="jumbotron" id="content" style="background: url(../images/bulles.png) repeat center left #c7edfa; margin-top: -20px">
        <div class="container">
            <div class="row">
                <div class="col-lg-4" style="margin-bottom: 15px">
                    <p>
                        <img alt="OpenFisca" class="img-responsive" src="${urls.get_url(ctx, 'images', 'logo-big.png')
                                }" title="OpenFisca, le bonheur autour de soi !">
                    </p>
                    <p class="lead">Moteur ouvert de simulation du système socio-fiscal</p>
                    <div><a class="btn btn-jumbotron btn-lg" href="${conf['ui.url']}" role="button">Simuler un cas type en ligne</a></div>
                </div>
                <div class="col-lg-8">
<%
    visualizations_node = node.child_from_node(ctx, unique_name = 'utilisations')
    featured_visualizations = sorted(
        (
            visualization
            for visualization in visualizations_node.iter_visualizations(ctx)
            if visualization.get('featured') is not None
            ),
        key = lambda visualization: visualization['featured']
        )
%>\
    % if featured_visualizations:
                    <div class="carousel slide" data-ride="carousel" id="carousel">
                        ## Indicators
                        <ol class="carousel-indicators">
        % for visualization in featured_visualizations:
                            <li data-target="#carousel" data-slide-to="${loop.index}"${
                                    u' class="active"' if loop.first else u'' | n}></li>
        % endfor
                        </ol>
                        ## Wrapper for slides
                        <div class="carousel-inner">
        % for visualization in featured_visualizations:
                            <div class="item${u' active' if loop.first else u''}">
                                <a href="${visualization['source_url']}"><img alt="Copie d'écran : ${
                                        visualization['title']}" src="${visualization['thumbnail_url']}"></a>
                                <div class="carousel-caption">
                                    <h4>${visualization['title']}</h4>
                                    ${visualization['owner']}
                                    ${babel.dates.format_date(
                                        datetime.date(*[
                                            int(number)
                                            for number in visualization['updated'].split('T')[0].split('-')
                                            ]),
                                        format = 'short',
                                        locale = ctx.lang[0][:2],
                                        )}
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
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <%self:container_content/>
    </div>
</%def>


<%def name="container_content()" filter="trim">
    <div class="row">
        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>API web</h4>
            <p class="text-justify">
                L'API web permet d'utiliser le moteur OpenFisca, sans l'installer, depuis n'importe quelle page web.
            </p>
            <p class="text-justify">
                Grâce aux serveurs publics mis à votre disposition par Etalab, vous pouvez utiliser pour illustrer
                un sujet de recherche, un article économique, réaliser une infographie dynamique.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'api')}" role="button">Utiliser l'API web</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Communauté</h4>
            <p class="text-justify">
                OpenFisca est un projet libre et ouvert à tous. Mais c'est surtout un projet très ambitieux, qui
                ne pourra pas réussir sans l'aide du plus grand nombre.
            </p>
            <p class="text-justify">
                Quelles que soient vos compétences, si OpenFisca vous intéresse, vous pouvez contribuer à son
                développement. Toutes les bonnes volontés sont les bienvenues.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'contribuer')}" role="button">Contribuer</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Débogueur en ligne</h4>
            <p class="text-justify">
                Un débogueur en ligne permet de visualiser les formules intervenant lors du calcul d'un cas type,
                de connaître leur ordre d'exécution, les valeurs de leurs paramètres et leur résultat.
            </p>
            <p class="text-justify">
                Comprendre le système socio-fiscal ou corriger le simulateur n'a jamais été aussi facile.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'exemple-trace')}" role="button">Déboguer en ligne</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Exemples</h4>
            <p class="text-justify">
                Pour vous permettre d'adapter OpenFisca à vos propres besoins, l'équipe OpenFisca développe et
                documente différents exemples, en essayant de recouvrir les différents cas d'usages possibles 
            </p>
            <p class="text-justify">
                Inspirez-vous de ces exemples pour réaliser vos propres projets.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'documentation')}" role="button">Étudier les exemples</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Installation</h4>
            <p class="text-justify">
                Si l'utilisation en ligne d'OpenFisca ne vous suffit pas, vous pouvez aussi installer les différents
                logiciels qui composent OpenFisca sur votre propre ordinateur, sur des serveurs ou même dans les
                nuages.
            </p>
            <p class="text-justify">
                Nous déployons de gros efforts afin qu'OpenFisca puisse fonctionner sur de plus en plus de
                systèmes différents.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'installation')}" role="button">Installer les logiciels</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Logiciel libre</h4>
            <p class="text-justify">
                OpenFisca est un simulateur ouvert sous licence libre. Cette licence vous permet d'utiliser
                OpenFisca, de l'installer, d'étudier son code source, de le modifier et devle redistribuer comme bon
                vous semble.
            </p>
            <p class="text-justify">
                Une seule contrainte : Les travaux dérivés d'OpenFisca doivent eux aussi être libres.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'a-propos')}" role="button">Connaître la licence</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Utilisations</h4>
            <p class="text-justify">
                OpenFisca commence déjà à être utilisé : durant des "hackathons", pour des projets de
                recherche, pour créer des simulateurs spécialisés, pour illustrer des propos, etc.
            </p>
            <p class="text-justify">
                Ce n'est qu'un début, mais ces premiers projets sont prometteurs.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'utilisations')}" role="button">Découvrir les utilisations</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h4>Variables et formules socio-fiscales</h4>
            <p class="text-justify">
                Nous vous proposons un petit outil web permettant de naviguer dans l'ensemble des variables et
                formules socio-fiscales implémentez dans OpenFisca.
            </p>
            <p class="text-justify">
                Découvrez les dépendances entre formules, naviguez de l'une à l'autre, parcourez leur code source et
                même aidez-nous à les améliorer.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'variables')}" role="button">Explorer les formules socio-fiscales</a></p>
        </div>
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'documentation')}">Voir toute la documentation...</a>
    </div>

<%
    visualizations_node = node.child_from_node(ctx, unique_name = 'utilisations')
    last_visualizations = list(itertools.islice(visualizations_node.iter_visualizations(ctx), 3))
%>\
    <div class="page-header">
        <h2>Dernières utilisations</h2>
    </div>
    <div class="row">
    % for visualization in last_visualizations:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${visualization['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h4>${visualization['title']}</h4>
                        <p class="text-justify">${visualization['description']}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${visualization['source_url']}" role="button">Voir</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'utilisations')}">Voir toutes les utilisations...</a>
    </div>

<%
    projects_node = node.child_from_node(ctx, unique_name = 'projets')
    last_projects = list(itertools.islice(projects_node.iter_projects(ctx), 3))
%>\
    <div class="page-header">
        <h2>Derniers projets</h2>
    </div>
    <div class="row">
    % for project in last_projects:
        <div class="col-md-4 col-sm-6" style="height: 180px">
            <h4>${project['title']}</h4>
            <p class="text-justify">${project['description']}</p>
            <p><a class="btn btn-jumbotron" href="${project['source_url']}" role="button">Voir le projet</a></p>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'projets')}">Voir tous les projets...</a>
    </div>

<%
    last_articles = list(itertools.islice(node.iter_latest_articles(ctx), 3))
%>\
    <div class="page-header">
        <h2>Actualité</h2>
    </div>
    <div class="row">
    % for article in last_articles:
        <article class="col-md-4 col-sm-6">
            <div class="ellipsis" style="height: 190px">
        % if article.get('title_url') is None:
                <h4>${article['title']}</h4>
        % else:
                <a href="${article['title_url']}" target="_blank"><h4>${article['title']}</h4></a>
        % endif
        % for child_element in article['element']:
                ${lxml.html.tostring(child_element, encoding = unicode) | n}
        % endfor
            </div>
            <p>
                <a class="btn btn-jumbotron" href="${urls.get_url(ctx, article['node'].url_path)}" role="button">Lire la suite</a>
            </p>
        </article>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'atom')}"><span class="label label-warning">Fil d'actualité</span></a>
        <a href="${urls.get_url(ctx, 'actualites')}">Voir toutes les actualités...</a>
    </div>

    <div class="page-header">
        <h2>Partenaires</h2>
    </div>
    <%self:partners/>
</%def>


<%def name="h1_content()" filter="trim">
${_(u'Home')}
</%def>


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/jQuery.dotdotdot/src/js/jquery.dotdotdot.min.js')}"></script>
    <script>
$(function () {
    $(".ellipsis").dotdotdot();
});
    </script>
</%def>
