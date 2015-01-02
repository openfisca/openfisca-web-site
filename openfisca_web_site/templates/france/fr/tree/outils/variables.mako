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
import collections
import json
import urllib2
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page-avec-nav.mako"/>


<%def name="body_attributes()" filter="trim">
data-spy="scroll" data-target="#sommaire"
</%def>


<%def name="h1_content()" filter="trim">
Variables et formules socio-fiscales
</%def>


<%def name="page_content()" filter="trim">
<%
    request = urllib2.Request(urlparse.urljoin(conf['urls.api'], '/api/1/fields'), headers = {
        'User-Agent': 'OpenFisca-Web-Site',
        })
    try:
        response = urllib2.urlopen(request)
    except urllib2.HTTPError as response:
        print response.read()
        raise
    response_json = json.loads(response.read(), object_pairs_hook = collections.OrderedDict)
%>\
    <div class="col-md-9" role="main">
        <h2 id="variables-en-entree">Variables en entrée</h2>

        <h3 id="variables-en-entree-individus">Variables en entrée pour les individus</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'ind':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-entree-familles">Variables en entrée pour les familles</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'fam':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-entree-foyers-fiscaux">Variables en entrée pour les foyers fiscaux</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'foy':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-entree-menages">Variables en entrée pour les ménages</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'men':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h2 id="variables-en-sortie">Variables en sortie</h2>

        <h3 id="variables-en-sortie-individus">Variables en sortie (formules) pour les individus</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'ind':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-sortie-familles">Variables en sortie (formules) pour les familles</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'fam':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-sortie-foyers-fiscaux">Variables en sortie (formules) pour les foyers fiscaux</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'foy':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3 id="variables-en-sortie-menages">Variables en sortie (formules) pour les ménages</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'men':
            continue
%>\
            <li>
                <a href="${urls.get_url(ctx, 'variables', variable['name'])}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>
    </div>
</%def>


<%def name="nav_content()" filter="trim">
            <li>
                <a href="#variables-en-entree">Variables en entrée</a>
                <ul class="nav">
                    <li><a href="#variables-en-entree-individus">Individus</a></li>
                    <li><a href="#variables-en-entree-familles">Familles</a></li>
                    <li><a href="#variables-en-entree-foyers-fiscaux">Foyers fiscaux</a></li>
                    <li><a href="#variables-en-entree-menages">Ménages</a></li>
                </ul>
            </li>
            <li>
                <li>
                    <a href="#variables-en-sortie">Formules</a>
                    <ul class="nav">
                        <li><a href="#variables-en-sortie-individus">Individus</a></li>
                        <li><a href="#variables-en-sortie-familles">Familles</a></li>
                        <li><a href="#variables-en-sortie-foyers-fiscaux">Foyers fiscaux</a></li>
                        <li><a href="#variables-en-sortie-menages">Ménages</a></li>
                    </ul>
                </li>
            </li>
</%def>
