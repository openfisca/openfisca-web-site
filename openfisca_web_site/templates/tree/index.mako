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
import urllib

import babel.dates
import lxml.html
import logging
from ttp import ttp
import twitter

from openfisca_web_site import conf, urls


log = logging.getLogger(__name__)
if conf['twitter.consumer_key'] is None:
    twitter_api = None
    twitter_parser = None
else:
    twitter_api = twitter.Api(
        consumer_key = conf['twitter.consumer_key'],
        consumer_secret = conf['twitter.consumer_secret'],
        access_token_key = conf['twitter.access_token_key'],
        access_token_secret = conf['twitter.access_token_secret'],
        )

    class TwitterParser(ttp.Parser):
        def format_list(self, at_char, user, list_name):
            '''Return formatted HTML for a list.'''
            return '<a href="http://twitter.com/%s/%s" target="_blank">%s%s/%s</a>' % (user, list_name, at_char, user,
                list_name)

        def format_tag(self, tag, text):
            '''Return formatted HTML for a hashtag.'''
            return '<a href="http://search.twitter.com/search?q=%s" target="_blank">%s%s</a>' % (
                urllib.quote('#' + text.encode('utf-8')), tag, text)

        def format_url(self, url, text):
            '''Return formatted HTML for a url.'''
            return '<a href="%s" target="_blank">%s</a>' % (ttp.escape(url), text)

        def format_username(self, at_char, user):
            '''Return formatted HTML for a username.'''
            return '<a href="http://twitter.com/%s" target="_blank">%s%s</a>' % (user, at_char, user)

    twitter_parser = TwitterParser()
twitter_statuses = None
twitter_statuses_updated = None
%>


<%inherit file="/index.mako"/>


<%def name="body_content()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
%>\
    <div class="jumbotron" id="content" style="background: url(${urls.get_url(ctx, 'elements', 'images', 'bulles.png')
            }) repeat center left #c7edfa; margin-top: -20px">
        <div class="container">
            <div class="row">
                <div class="col-lg-4" style="margin-bottom: 15px">
                    <p>
                        <img alt="OpenFisca" class="img-responsive" src="${urls.get_url(ctx, 'elements', 'images',
                                'logo-openfisca-280x200.png')}">
                    </p>
                    <em class="lead" style="color: white; font-size: 32px">Moteur ouvert de simulation du système socio-fiscal</em>
##                    <div><a class="btn btn-jumbotron btn-lg" href="${conf['ui.url']}" role="button">Simuler un cas type en ligne</a></div>
                </div>
                <div class="col-lg-8">
<%
    items = sorted(
        (
            item
            for item in items_node.iter_items(ctx)
            if item.get('carousel_rank') is not None
            ),
        key = lambda item: item['carousel_rank']
        )
%>\
                    <div class="carousel slide" data-ride="carousel" id="carousel">
                        ## Indicators
                        <ol class="carousel-indicators">
    % for item in items:
                            <li data-target="#carousel" data-slide-to="${loop.index}"${
                                    u' class="active"' if loop.first else u'' | n}></li>
    % endfor
                        </ol>
                        ## Wrapper for slides
                        <div class="carousel-inner">
    % for item in items:
                            <div class="item${u' active' if loop.first else u''}">
##                                <a href="${item['source_url']}"><img alt="Copie d'écran : ${item['title']}" src="${
##                                        item['thumbnail_url']}"></a>
                                <img alt="Copie d'écran : ${item['title']}" src="${item['thumbnail_url']}">
                                <div class="carousel-caption">
                                    <h3>${item['title']}</h3>
                                    ${item['owner']}, ${babel.dates.format_date(
                                        datetime.date(*[
                                            int(number)
                                            for number in item['updated'].split('T')[0].split('-')
                                            ]),
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
                </div>
            </div>
        </div>
    </div>

    <div class="container">
        <%self:container_content/>
    </div>
</%def>


<%def name="container_content()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
%>\
    <div class="row">
        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h3>Présentation</h3>
            <p class="text-justify">
                 OpenFisca est un moteur ouvert de micro-simulation du système socio-fiscal français. Il permet de
                 calculer simplement un grand nombre de prestations sociales et d'impôts payés, par les ménages, et de
                 simuler l'impact de réformes sur leur budget.
            </p>
            <p class="text-justify">
                Il s'agit d'un outil à <strong>vocation pédagogique</strong> pour aider les
                citoyens à mieux comprendre le système socio-fiscal.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'presentation')}" role="button">Lire la suite</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h3>API web</h3>
            <p class="text-justify">
                L'API web permet d'utiliser le moteur OpenFisca, sans l'installer, depuis n'importe quelle page web.
            </p>
            <p class="text-justify">
                Grâce aux serveurs mis à votre disposition sur Internet par
                <a href="http://www.etalab.gouv.fr" target="_blank">Etalab</a>, vous pouvez utiliser l'API pour
                illustrer un sujet de recherche, un article économique, réaliser une infographie dynamique, etc.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'api')}" role="button">Utiliser l'API web</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h3>Démonstration</h3>
            <p class="text-justify">
                Pour illustrer les possibilités offertes par l'API web, nous avons réalisé un simulateur en ligne.
            </p>
            <p class="text-justify">
                Grâce à ce <strong>démonstrateur</strong>, décrivez votre situation familiale, saisissez vos revenus et
                votre patrimoine, et découvrez votre situation socio-fiscale, situez-vous par rapport aux autres foyers,
                découvrez votre niveau de vie, etc.
            </p>
            <p><a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'api')}" role="button">Simuler un cas type en ligne</a></p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 260px">
            <h3>Installation</h3>
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
            <h3>Logiciel libre</h3>
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
            <h3>Communauté</h3>
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
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'documentation')}"><em class="lead">Voir toute la documentation...</em></a>
    </div>

<%
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items(ctx)
            if u'exemple' in (item.get('tags') or []) and u'outil' not in (item.get('tags') or [])
            ),
        3,
        ))
%>\
    <div class="page-header">
        <h2>Exemples</h2>
    </div>
    <p class="text-justify">
        Pour vous permettre d'adapter OpenFisca à vos besoins, l'équipe OpenFisca développe et
        documente différents exemples, en essayant de couvrir les différents cas d'usages possibles.
    </p>
    <p class="text-justify">
        Vous pouvez vous inspirer de ces exemples pour réaliser vos propres projets.
    </p>
    <div class="row">
    % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description']}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">Étudier</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'exemples')}"><em class="lead">Voir tous les exemples...</em></a>
    </div>

<%
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items(ctx)
            if u'outil' in (item.get('tags') or [])
            ),
        3,
        ))
%>\
    <div class="page-header">
        <h2>Outils</h2>
    </div>
    <p class="text-justify">
        Pour vous aider à mieux comprendre le fonctionnement d'OpenFisca, à améliorer ses formules socio-fiscales,
        à compléter la législation, etc, nous développons différents outils web de visualisation, d'exploration et de
        déboguage.
    </p>
    <p class="text-justify">
        Ces outils sont aussi, en eux-mêmes, des exemples d'utilisation de l'API OpenFisca.
    </p>
    <div class="row">
    % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description']}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">Utiliser</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'outils')}"><em class="lead">Voir tous les outils...</em></a>
    </div>

<%
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items(ctx)
            if u'projet' in (item.get('tags') or [])
            ),
        3,
        ))
%>\
    <div class="page-header">
        <h2>Projets</h2>
    </div>
    <div class="row" style="margin-bottom: 20px">
    % for item in items:
        <div class="col-md-4 col-sm-6" style="height: 180px">
            <h3>${item['title']}</h3>
            <p class="text-justify">${item['description']}</p>
            <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">En savoir plus</a></p>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'projets')}"><em class="lead">Voir tous les projets...</em></a>
    </div>

<%
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items(ctx)
            if u'utilisation' in (item.get('tags') or [])
            ),
        3,
        ))
%>\
    <div class="page-header">
        <h2>Utilisations</h2>
    </div>
    <p class="text-justify">
        OpenFisca commence déjà à être utilisé : durant des "hackathons", pour des projets de
        recherche, pour créer des simulateurs spécialisés, pour illustrer des propos, etc.
    </p>
    <p class="text-justify">
        Ce n'est qu'un début, mais ces premiers projets sont prometteurs.
    </p>
    <div class="row">
    % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description']}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">En savoir plus</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'utilisations')}"><em class="lead">Voir toutes les utilisations...</em></a>
    </div>

    % if twitter_api is not None:
<%
        global twitter_statuses, twitter_statuses_updated
        if twitter_statuses_updated is None \
                or twitter_statuses_updated + datetime.timedelta(minutes = 5) < datetime.datetime.utcnow():
            try:
                twitter_statuses = twitter_api.GetUserTimeline('OpenFisca', count = 9)
            except:
                log.exception(u"An error occurred while calling twitter_api.GetUserTimeline('OpenFisca')")
                twitter_statuses = []
            twitter_statuses_updated = datetime.datetime.utcnow()
%>\
        % if twitter_statuses:
    <div class="page-header">
        <h2>Tweets <small>@OpenFisca</small></h2>
    </div>
            % for status_index, status in enumerate(twitter_statuses):
                % if status_index % 3 == 0:
    <div class="row" style="margin-bottom: 20px">
                % endif
        <div class="col-md-4 col-sm-6">
            <p>${twitter_parser.parse(status.text).html | n}</p>
            <div class="text-muted text-right">
                ${babel.dates.format_date(
                    datetime.date.fromtimestamp(status.created_at_in_seconds),
                    locale = ctx.lang[0][:2],
                    )}
            </div>
        </div>
                % if status_index % 3 == 2:
    </div>
                % endif
            % endfor
    <div class="text-right">
        <a href="https://twitter.com/OpenFisca" target="_blank"><em class="lead">Voir tous les tweets...</em></a>
    </div>
        % endif
    % endif

<%
    last_articles = list(itertools.islice(node.iter_latest_articles(ctx), 3))
%>\
    <div class="page-header">
        <h2>Actualités</h2>
    </div>
    <div class="row" style="margin-bottom: 20px">
    % for article in last_articles:
        <article class="col-md-4 col-sm-6">
            <div class="ellipsis" style="height: 195px">
        % if article.get('title_url') is None:
                <h3>${article['title']}</h3>
        % else:
                <a href="${article['title_url']}" target="_blank"><h3>${article['title']}</h3></a>
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
        <a href="${urls.get_url(ctx, 'actualites')}"><em class="lead">Voir toutes les actualités...</em></a>
        <br>
        <a href="${urls.get_url(ctx, 'atom')}"><span class="label label-warning">Fil d'actualité</span></a>
    </div>

    <div class="page-header">
        <h2>Porteurs du projet</h2>
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
