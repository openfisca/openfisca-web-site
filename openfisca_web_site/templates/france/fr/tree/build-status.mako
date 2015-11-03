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
def call_travis_api(endpoint):
    url = 'https://api.travis-ci.org{}'.format(endpoint)
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
    repos_json = call_travis_api('/repos?slug=openfisca%2F{}'.format(repository_name))
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
    'openfisca-france-reform-landais-piketty-saez',
    'openfisca-web-ui',
    'openfisca-tunisia',
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

<h2>By branch</h2>

<h3 id="branch-master">master</h3>

<ul>
    % for repository_name in ['openfisca-core', 'openfisca-france', 'openfisca-web-api']:
    <li>
        ${repository_name}
        ${travis_badge(
            branch = 'master',
            build_json = build_json_by_branch_by_repository_name[repository_name].get('master'),
            repository_name = repository_name,
            )}
    </li>
    % endfor
</ul>

<h2>By repository</h2>

${self.repo_table(
    branches = ['prod', 'master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-core'),
    repository_name = 'openfisca-core',
    )}
${self.repo_table(
    branches = ['prod', 'master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-france'),
    repository_name = 'openfisca-france',
    )}
${self.repo_table(
    branches = ['prod', 'master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-web-api'),
    repository_name = 'openfisca-web-api',
    )}
${self.repo_table(
    branches = ['master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-france-reform-landais-piketty-saez'),
    repository_name = 'openfisca-france-reform-landais-piketty-saez',
    )}
${self.repo_table(
    branches = ['prod', 'master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-web-ui'),
    repository_name = 'openfisca-web-ui',
    )}
${self.repo_table(
    branches = ['master'],
    build_json_by_branch = build_json_by_branch_by_repository_name.get('openfisca-tunisia'),
    repository_name = 'openfisca-tunisia',
    )}
</%def>


<%def name="repo_table(branches, repository_name, build_json_by_branch = None)" filter="trim">
<h3 id="${repository_name}">${repository_name}</h3>
% if build_json_by_branch is None:
<div class="alert alert-warning">
Could not fetch information about branches from Travis API for this repository.
</div>
% endif
<table class="table table-bordered table-hover table-striped">
    <thead>
        <tr>
            <th>Branch</th>
            <th>Travis</th>
            <th>GitHub</th>
        </tr>
    </thead>
    % for branch in branches:
<%
build_json = build_json_by_branch.get(branch) \
    if build_json_by_branch is not None \
    else None
%>
    <%self:travis_badge_row branch="${branch}" build_json="${build_json}" repository_name="${repository_name}" />
    % endfor
</table>
</%def>


<%def name="travis_badge_row(branch, build_json, repository_name)" filter="trim">
<tr>
    <td>${branch}</td>
    <td>
        <%self:travis_badge branch="${branch}" build_json="${build_json}" repository_name="${repository_name}" />
    </td>
    <td>
        <a href="https://github.com/openfisca/${repository_name}/tree/${branch}/" rel="external" target="_blank">
            ${repository_name}/${branch}
        </a>
    </td>
</tr>
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
