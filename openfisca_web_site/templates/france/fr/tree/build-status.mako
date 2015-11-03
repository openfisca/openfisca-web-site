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
import json
import urllib2
import urlparse

from openfisca_web_site import conf
%>


<%page cached="False" />


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Build Status
</%def>


<%def name="page_content()" filter="trim">
<%
def call_travis_api(url_path):
    url = 'https://api.travis-ci.org{}'.format(url_path)
    request = urllib2.Request(url, headers = {'Accept': 'application/json', 'User-Agent': 'OpenFisca-Web-Site'})
    try:
        response = urllib2.urlopen(request)
    except urllib2.HTTPError as response:
        print url, response
    response_text = response.read()
    try:
        response_json = json.loads(response_text)
    except ValueError, error:
        print url, response_text, error
    return response_json

def fetch_build_json_by_branch(repository_name):
    url_path = '/repos?slug=openfisca%2F{}'.format(repository_name)
    repos_json = call_travis_api(url_path)
    repository_id = repos_json[0]['id'] \
        if repos_json is not None and isinstance(repos_json, list) \
        else None
    if repository_id is not None:
        builds_json = call_travis_api('/builds?branches=true&repository_id={}'.format(repository_id))
        build_json_by_branch = {
            build_json['branch']: build_json
            for build_json in builds_json
            } if builds_json is not None and isinstance(builds_json, list) else None
    else:
        build_json_by_branch = None
    return build_json_by_branch

repositories_name = [
    'openfisca-core',
    'openfisca-france',
    'openfisca-web-api',
    ## 'openfisca-web-ui',
    ## 'openfisca-tunisia',
    ]
build_json_by_branch_by_repository_name = {
    repository_name: fetch_build_json_by_branch(repository_name)
    for repository_name in repositories_name
    }
%>

<p>
  The
  <a href="${urlparse.urljoin(conf['urls.gitbook'], 'contribute/development-process.html')}">
    development process
  </a>
  section of the <a href="${conf['urls.gitbook']}">documentation</a> presents the different branches.
</p>

<ul>
    % for repository_name in ['openfisca-core', 'openfisca-france', 'openfisca-web-api']:
    <li>
        <a href="https://github.com/openfisca/${repository_name}" rel="external" target="_blank">\
${repository_name}</a>
        ${travis_badge(
            branch = 'master',
            build_json = build_json_by_branch_by_repository_name[repository_name].get('master'),
            repository_name = repository_name,
            )}
    </li>
    % endfor
</ul>
</%def>


<%def name="travis_badge(branch, build_json, repository_name)" filter="trim">
<%
build_id = build_json.get('id') \
    if build_json is not None \
    else None
build_state = build_json.get('state') \
    if build_json is not None \
    else None
href = u'https://travis-ci.org/openfisca/{}/builds/{}'.format(repository_name, build_id)\
    if build_id is not None \
    else u'https://travis-ci.org/openfisca/{}/branches'.format(repository_name)
%>
<a href="${href}" rel="external" target="_blank">\
<img alt="travis build status" src="https://travis-ci.org/openfisca/${repository_name}.svg?branch=${branch}" />\
</a>
% if build_state == 'started':
<span class="label label-warning">pending</span>
% endif
</%def>
