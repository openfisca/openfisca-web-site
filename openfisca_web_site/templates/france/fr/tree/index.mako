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
import lxml.etree
import lxml.html
import logging
from toolz import partition_all
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
                        <img alt="OpenFisca" class="img-responsive" src="/hotlinks/logo-openfisca.svg">
                    </p>
                    <em class="lead" style="color: white; font-size: 32px">
                        ${_(u'Open models to compute tax and benefit systems')}
                    </em>
                </div>
                <div class="col-lg-8">
<%
    items = sorted(
        (
            item
            for item in items_node.iter_items()
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
                                    <h3><a href="${item['source_url']}">${item['title']}</a></h3>
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
                        <a class="carousel-control left" href="#carousel" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left"></span>
                        </a>
                        <a class="carousel-control right" href="#carousel" data-slide="next">
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


<%def name="calculette_impots_blocks()" filter="trim">
    <div class="page-header">
        <h2>Calculette Impôts</h2>
    </div>
    <div class="row">
        <div class="col-md-8">
            <p class="text-justify">
                 La « Calculette Impôts » est le logiciel écrit par la <a href="http://www.economie.gouv.fr/dgfip"><abbr title="Direction générale des Finances publiques">DGFiP</abbr></a> qui calcule l'impôt sur les revenus des particuliers.
            </p>
            <p class="text-justify">
                Ce logiciel a été ouvert par l'administration en avril 2016. Il est écrit en <a href="https://git.framasoft.org/openfisca/calculette-impots-m-source-code">langage M</a> – langage développé en interne à la DGFiP – et contient les règles de calcul de l'impôt telles que décrites dans la législation.
            </p>
            <p class="text-justify">
                La Calculette Impôts n'est pas OpenFisca : ce sont deux logiciels différents.
                Cependant l'équipe d'OpenFisca a travaillé autour de son ouverture, en particulier en écrivant
                un <a href="https://git.framasoft.org/openfisca/calculette-impots-python">traducteur en Python</a> du langage M,
                permettant d'exécuter des calculs sur n'importe quel ordinateur disposant du langage de programmation Python.
            </p>
            <p class="text-justify">
                Puis un hackathon célébrant cette ouverture a eu lieu début avril 2016, et a accueilli plusieurs ateliers qui ont donné naissance à des outils gravitant autour du code M.
            </p>
        </div>
    </div>
</%def>


<%def name="community()" filter="trim">
    <div class="page-header">
        <h2>Logiciel libre et Communauté</h2>
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
        OpenFisca est un projet ouvert à tous. Mais c'est surtout un projet très ambitieux, qui
        ne pourra pas réussir sans l'aide du plus grand nombre.
        Quelles que soient vos compétences, si la fiscalité vous intéresse, vous pouvez contribuer au développement.
        Toutes les bonnes volontés sont les bienvenues, que vous soyez chercheur, économiste,
        agent de l'administration publique, étudiant ou citoyen intéressé par l'ouverture des modèles.
    </p>
    <p class="text-justify">
        La communauté OpenFisca a déjà fourni un énorme travail de représentation de la législation française,
        de développement du moteur de calcul et de réalisation de produits utilisant OpenFisca,
        comme le site gouvernemental <a href="https://mes-aides.gouv.fr/">mes-aides.gouv.fr</a>.
        Voir la <a href="https://github.com/openfisca/openfisca-france#contributors">liste des contributeurs à OpenFisca-France</a>,
        le dépôt contenant la traduction en code source Python du système socio-fiscal français.
    </p>
    <p class="text-justify">
        OpenFisca commence déjà à être utilisé : durant des « hackathons », pour des projets de
        recherche, pour créer des simulateurs spécialisés, pour illustrer des propos, etc.
        Contactez-nous pour ajouter votre projet !
    </p>
    <%self:community_elements/>
</%def>


<%def name="community_elements()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
    items = [
        item
        for item in items_node.iter_items()
        if u'community' in (item.get('tags') or [])
            and (item.get('country') is None or any(country == conf['country'] for country in item.get('country')))
        ]
%>\
    % if items:
    <div class="row" style="margin-top: 3em">
        % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description'] if isinstance(item['description'], basestring) else item['description'].get(ctx.lang[0], item['description']['fr'])}</p>
                    </div>
                    <p>
                        <a class="btn btn-jumbotron" href="${item['source_url']}" role="button">
                            ${_(u'Use')}
                        </a>
                    </p>
                </div>
            </div>
        </div>
        % endfor
    </div>
    % endif
</%def>


<%def name="container_content()" filter="trim">
    <%self:openfisca_blocks/>
    <%self:news/>
    <%self:community/>
    <%self:calculette_impots_blocks/>
    <%self:twitter/>
    <%self:partners/>
</%def>


<%def name="h1_content()" filter="trim">
Accueil
</%def>


<%def name="news()" filter="trim">
<%
    last_articles = list(itertools.islice(node.iter_latest_articles(), 3))
%>\
    % if last_articles:
    <div class="page-header">
        <h2 style="display: inline-block;">Actualités</h2>
        <a href="${urls.get_url(ctx, 'atom')}" title="Utiliser dans un lecteur de flux RSS/Atom"><span class="label label-warning">Flux Atom</span></a>
    </div>
    <div class="row" style="margin-bottom: 20px">
        % for article in last_articles:
        <article class="col-md-4">
            <div class="ellipsis" style="height: 190px">
                <h3>${article['title']}</h3>
            % for child_element in article['element']:
<%
                if child_element.tag == 'img':
                    continue
                lxml.etree.strip_elements(
                    child_element,
                    'img',
                    with_tail = False,
                    )
%>
                ${lxml.html.tostring(child_element, encoding = unicode) | n}
            % endfor
            </div>
            <div class="text-muted text-right">
                ${babel.dates.format_date(
                    datetime.date(*(
                        int(fragment)
                        for fragment in article['updated'].split(u'-')
                        )),
                    locale = ctx.lang[0][:2],
                    )}
            </div>
            <p style="margin-top: 10px">
                <a class="btn btn-jumbotron" href="${urls.get_url(ctx, article['node'].url_path)}" role="button">Lire la suite</a>
            </p>
        </article>
        % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'actualites')}"><em class="lead">Voir toutes les actualités...</em></a>
    </div>
    % endif
</%def>


<%def name="openfisca_blocks()" filter="trim">
    <div class="row">
        <div class="col-md-4">
            <h3>Présentation</h3>
            <p class="text-justify">
                OpenFisca est un moteur ouvert de micro-simulation du système socio-fiscal. Il permet entre autres de
                calculer un grand nombre de prestations sociales et d'impôts payés par les ménages, et de
                simuler l'impact de réformes sur leur budget.
            </p>
            <p class="text-justify">
                Il s'agit d'un outil à <em>vocation pédagogique</em> pour aider les
                citoyens à mieux comprendre le système socio-fiscal.
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'index.html')}" role="button">
                    Lire la suite
                </a>
            </p>
        </div>
        <div class="col-md-4">
            <h3>API web</h3>
            <p class="text-justify">
                L'API web permet d'utiliser le moteur OpenFisca, sans l'installer, depuis n'importe quelle page web.
            </p>
            <p class="text-justify">
                Grâce aux serveurs mis à votre disposition sur Internet par
                <a href="http://www.etalab.gouv.fr" target="_blank">Etalab</a>, vous pouvez utiliser l'API pour
                illustrer un sujet de recherche, un article économique, réaliser une infographie dynamique, etc.
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'openfisca-web-api/index.html')}" role="button">
                    Utiliser l'API web
                </a>
            </p>
        </div>
        <div class="col-md-4">
            <h3>Installation</h3>
            <p class="text-justify">
                Si l'utilisation en ligne d'OpenFisca ne vous suffit pas, vous pouvez aussi installer les différents
                logiciels qui composent OpenFisca sur votre propre ordinateur, sur des serveurs ou même dans le
                "cloud".
            </p>
            <p>
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'install.html')}" role="button">
                    Installer OpenFisca
                </a>
            </p>
        </div>
    </div>
    <%self:openfisca_elements/>
</%def>


<%def name="openfisca_elements()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
    items_tuples = partition_all(
        3,
        (
            item
            for item in items_node.iter_items()
            if u'tool' in (item.get('tags') or [])
                and (item.get('country') is None or any(country == conf['country'] for country in item.get('country')))
            ),
        )
%>\
    % for items_tuple in items_tuples:
    <div class="row" style="margin-top: 3em">
        % for item in items_tuple:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">
                          ${item['description'] if isinstance(item['description'], basestring) else item['description'].get(ctx.lang[0], item['description']['fr'])}
                        </p>
                    </div>
                    <p>
                        <a class="btn btn-jumbotron" href="${item['source_url']}" role="button">
                            ${_(u'Use')}
                        </a>
                    </p>
                </div>
            </div>
        </div>
        % endfor
    </div>
    % endfor
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_static_url(ctx, u'/bower/anchor-js/anchor.min.js')}"></script>
    <script src="${urls.get_static_url(ctx, u'/bower/jQuery.dotdotdot/src/js/jquery.dotdotdot.min.js')}"></script>
    <script>
$(function () {
    anchors.options = {
      placement: 'left'
    };
    anchors.add('h2');
    $(".ellipsis").dotdotdot();
});
    </script>
</%def>


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>


<%def name="twitter()" filter="trim">
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
        <h2>Tweets <small><a href="https://twitter.com/OpenFisca" rel="external" target="_blank">@OpenFisca</a></small></h2>
    </div>
    <div class="row" style="margin-bottom: 20px">
            % for status_index, status in enumerate(twitter_statuses):
        <div class="col-md-4" style="height: 120px">
            <p>${twitter_parser.parse(status.text).html | n}</p>
            <div class="text-muted text-right">
                ${babel.dates.format_date(
                    datetime.date.fromtimestamp(status.created_at_in_seconds),
                    locale = ctx.lang[0][:2],
                    )}
            </div>
        </div>
            % endfor
    </div>
    <div class="text-right">
        <a href="https://twitter.com/OpenFisca" rel="external" target="_blank"><em class="lead">Voir tous les tweets...</em></a>
    </div>
        % endif
    % endif
</%def>
