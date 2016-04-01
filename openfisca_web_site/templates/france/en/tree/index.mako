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


<%inherit file="/france/fr/tree/index.mako"/>


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
                        <img alt="OpenFisca" class="img-responsive" src="/hotlinks/logo-openfisca.svg"> </p>
                    <em class="lead" style="color: white; font-size: 32px">Open tax-benefit system simulator</em>
##                    <div><a class="btn btn-jumbotron btn-lg" href="${conf['urls.ui']}" role="button">Simuler un cas type en ligne</a></div>
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


<%def name="community()" filter="trim">

<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items()
            if u'community' in (item.get('tags') or [])
                and (item.get('country') is None or any(country == conf['country'] for country in item.get('country')))
            ),
        3,
        ))
%>\
    % if items:
    <div class="page-header">
        <h2>Community</h2>
    </div>
    <p class="text-justify">
        OpenFisca has already been used for project developed during
        hackathons to produce new visualisations, illustrate some research, create specialized
        simulators, etc.
    </p>
    <p class="text-justify">
       This is just the beginning, but these early projects are promising.
       Contact us to add your project!
    </p>
    <div class="row">
        % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description'] if isinstance(item['description'], basestring) else item['description'].get(ctx.lang[0], item['description']['fr'])}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">Read more</a></p>
                </div>
            </div>
        </div>
        % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'community')}"><em class="lead">See all the community's projects...</em></a>
    </div>
    % endif
</%def>


<%def name="container_content()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
%>\
    <div class="row">
        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Presentation</h3>
            <p class="text-justify">
                 OpenFisca is an open micro-simulator of the tax-benefit system.
                 It allows users to simply calculate many social benefits and taxes
                 paid by households and to simulate the impact of reforms on their budget.
            </p>
            <p class="text-justify">
                This tool has an <em>educational purpose</em>, and aims
                to help citizens better understand the tax-benefit system.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'presentation.html')}" role="button">
                    Read more
                </a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Web API</h3>
            <p class="text-justify">
               The API lets you use the web OpenFisca engine, without installing it, from any web page.
            </p>
            <p class="text-justify">
                The servers made available on the Internet by
                <a href="http://www.etalab.gouv.fr" target="_blank">Etalab</a> allow you to use the API to illustrate
                a research project, an economic article, to create a dynamic infographics, etc.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'openfisca-web-api/index.html')}" role="button">
                    Use the web API
                </a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Test-case simulation</h3>
            <p class="text-justify">
                To illustrate the possibilities offered by the web API, we created an online simulator.
            </p>
            <p class="text-justify">
                With this <em>demonstrator</em>, by describing your family situation and entering your income
                and assets, you can compare your tax-benefit situation with that of other households, discover your
                living standard, etc.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${conf['urls.ui']}" role="button">Simulate a test case</a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Installation</h3>
            <p class="text-justify">
                If the use of OpenFisca online is not enough for you, you can also install
                different OpenFisca softwares on your own computer, on servers or even in the "cloud".
            </p>
            <p class="text-justify">
                We are working hard to make OpenFisca compatible with the greatest number of systems.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'install.html')}" role="button">
                    Installation
                </a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Free software</h3>
            <p class="text-justify">
                OpenFisca is an open simulator under a free license. This license allows you to use OpenFisca,
                install it, study its source code, modify and redistribute it as you see fit.
            </p>
            <p class="text-justify">
                The only constraint: OpenFisca re-uses must also be free of use.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urls.get_url(ctx, 'about')}" role="button">About</a>
            </p>
        </div>

        <div class="col-md-4 col-sm-6" style="height: 280px">
            <h3>Community</h3>
            <p class="text-justify">
                OpenFisca is a free project, open to all. But it is first and foremost a very ambitious project, which cannot
                succeede without the help of many.
            </p>
            <p class="text-justify">
                Whatever your qualifications, if you are interested in OpenFisca, you can contribute to its development. All people of
                good will are welcome.
            </p>
            <p style="margin-top: 20px">
                <a class="btn btn-jumbotron" href="${urlparse.urljoin(conf['urls.gitbook'], 'contribute/index.html')}" role="button">
                    Contribute
                </a>
            </p>
        </div>
    </div>
    <div class="text-right">
        <a href="${conf['urls.gitbook']}"><em class="lead">See all documentation...</em></a>
    </div>

    <%self:tools/>

    <%self:community/>

    <%self:news/>

    <%self:twitter/>

    <div class="page-header">
        <h2>Partners</h2>
    </div>
    <%self:partners/>
</%def>


<%def name="h1_content()" filter="trim">
Home
</%def>


<%def name="news()" filter="trim">
<%
    last_articles = list(itertools.islice(node.iter_latest_articles(), 3))
%>\
  % if last_articles:
    <div class="page-header">
        <h2>News</h2>
    </div>
    <div class="row" style="margin-bottom: 20px">
        % for article in last_articles:
        <article class="col-md-4 col-sm-6">
            <div class="ellipsis" style="height: 190px">
                <h3>${article['title']}</h3>
            % for child_element in article['element']:
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
                <a class="btn btn-jumbotron" href="${urls.get_url(ctx, article['node'].url_path)}" role="button">Read more</a>
            </p>
        </article>
        % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'actualites')}"><em class="lead">View all the news...</em></a>
        <br>
        <a href="${urls.get_url(ctx, 'atom')}"><span class="label label-warning">Newsfeed</span></a>
    </div>
    % endif
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_static_url(ctx, u'/bower/jQuery.dotdotdot/src/js/jquery.dotdotdot.min.js')}"></script>
    <script>
$(function () {
    $(".ellipsis").dotdotdot();
});
    </script>
</%def>


<%def name="title_content()" filter="trim">
<%self:brand/>
</%def>


<%def name="tools()" filter="trim">
<%
    items_node = node.child_from_node(ctx, unique_name = 'elements')
    items = list(itertools.islice(
        (
            item
            for item in items_node.iter_items()
            if u'tool' in (item.get('tags') or [])
                and (item.get('country') is None or any(country == conf['country'] for country in item.get('country')))
            ),
        3,
        ))
%>\
    % if items:
    <div class="page-header">
        <h2>Tools</h2>
    </div>
    <p class="text-justify">
        To improve your understanding of OpenFisca, to enhance its tax and benefit formulas,
        to complete the legislation, etc, we develop several web tools for visualization, exploration and
        debug.
    </p>
    <p class="text-justify">
        These tools are also, in themselves, examples of use of the web API of OpenFisca.
    </p>
    <div class="row">
    % for item in items:
        <div class="col-md-4">
            <div class="thumbnail">
                <img src="${item['thumbnail_url']}" style="width: 300px; height: 200px">
                <div class="caption">
                    <div class="ellipsis" style="height: 120px">
                        <h3>${item['title']}</h3>
                        <p class="text-justify">${item['description'] if isinstance(item['description'], basestring) else item['description'].get(ctx.lang[0], tem['description']['fr'])}</p>
                    </div>
                    <p><a class="btn btn-jumbotron" href="${item['source_url']}" role="button">Use</a></p>
                </div>
            </div>
        </div>
    % endfor
    </div>
    <div class="text-right">
        <a href="${urls.get_url(ctx, 'tools')}"><em class="lead">See all the available tools...</em></a>
    </div>
    % endif
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
        <h2>Tweets <small>@OpenFisca</small></h2>
    </div>
    <div class="row" style="margin-bottom: 20px">
            % for status_index, status in enumerate(twitter_statuses):
        <div class="col-md-4 col-sm-6" style="height: 120px">
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
        <a href="https://twitter.com/OpenFisca" target="_blank"><em class="lead">All the tweets...</em></a>
    </div>
        % endif
    % endif
</%def>
