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

from openfisca_web_site import conf
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Build Status
</%def>


<%def name="page_content()" filter="trim">
<h2>Development process</h2>

<p>
  See the
  <a href="${conf['urls.gitbook'] + 'contribute/development-process.html'}">
    development process
  </a>
  section in the documentation.
</p>

${self.repo_table(branches = ['prod', 'master', 'next', 'oldmaster'], repo = "openfisca-core")}
${self.repo_table(branches = ['prod', 'master', 'next', 'oldmaster'], repo = "openfisca-france")}
${self.repo_table(branches = ['master'], repo = "openfisca-france-reform-landais-piketty-saez")}
${self.repo_table(branches = ['prod', 'master', 'next'], repo = "openfisca-web-api")}
${self.repo_table(branches = ['prod', 'master', 'next'], repo = "openfisca-web-ui")}
${self.repo_table(branches = ['master'], repo = "openfisca-tunisia")}
</%def>


<%def name="repo_table(branches, repo)" filter="trim">
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

repos = call_travis_api('/repos?slug=openfisca%2F{}'.format(repo))
repo_id = repos[0]['id'] \
    if repos is not None and isinstance(repos, list) \
    else None
if repo_id is not None:
    builds = call_travis_api('/builds?branches=true&repository_id={}'.format(repo_id))
    build_id_by_branch = {
        build['branch']: build['id']
        for build in builds
        } if builds is not None and isinstance(builds, list) else None
else:
    build_id_by_branch = None
%>
<h2 id="${repo}">${repo}</h2>
% if build_id_by_branch is None:
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
  <tr>
    <%self:travis_badge branch="${branch}" build_id_by_branch="${build_id_by_branch}" repo="${repo}" />
  </tr>
    % endfor
</table>
</%def>


<%def name="travis_badge(branch, build_id_by_branch, repo)" filter="trim">
<%
build_id = build_id_by_branch.get(branch) \
    if build_id_by_branch is not None \
    else None
href =  u'https://travis-ci.org/openfisca/{}/builds/{}'.format(repo, build_id)\
    if build_id is not None \
    else u'https://travis-ci.org/openfisca/{}/branches'.format(repo)
%>
<td>${branch}</td>
<td>
  <a href="${href}" rel="external" target="_blank" title="branch ${branch}">\
<img alt="travis build status" src="https://travis-ci.org/openfisca/${repo}.svg?branch=${branch}" />\
</a>
</td>
<td>
  <a href="https://github.com/openfisca/${repo}/tree/${branch}/" rel="external" target="_blank">
    ${repo}/${branch}
  </a>
</td>
</%def>
