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
import collections
import json
import urllib2
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Variables socio-fiscales
</%def>


<%def name="page_content()" filter="trim">
<%
    request = urllib2.Request(urlparse.urljoin(conf['api.url'], '/api/1/fields'), headers = {
        'User-Agent': 'OpenFisca-Web-Site',
        })
    try:
        response = urllib2.urlopen(request)
    except urllib2.HTTPError as response:
        print response.read()
        raise
    response_json = json.loads(response.read(), object_pairs_hook = collections.OrderedDict)
%>\
        <h2>Variables en entrée</h2>

        <h3>Variables en entrée pour les individus</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'ind':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en entrée pour les familles</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'fam':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en entrée pour les foyers fiscaux</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'foy':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en entrée pour les ménages</h3>
        <ul>
    % for name, variable in response_json['columns'].iteritems():
<%
        if variable['entity'] != 'men':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h2>Variables en sortie</h2>

        <h3>Variables en sortie pour les individus</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'ind':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en sortie pour les familles</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'fam':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en sortie pour les foyers fiscaux</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'foy':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>

        <h3>Variables en sortie pour les ménages</h3>
        <ul>
    % for name, variable in response_json['prestations'].iteritems():
<%
        if variable['entity'] != 'men':
            continue
%>\
            <li>
                <a href="variables/${variable['name']}">${variable['name']}</a>
        % if variable.get('label'):
                : ${variable['label']}
        % endif
             </li>
    % endfor
        </ul>
</%def>
