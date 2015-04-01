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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Build Status
</%def>


<%def name="page_content()" filter="trim">
<h2>Rules</h2>
<p>To merge a pull-request into "next" the tests must pass on the repository (make test-ci).</p>
<p>
  When all tests pass in core, france and web-api repositories, and after a discussion with the core team,
  the release manager merges the "next" branch into "master" for each repository.
</p>

${self.repo_table(branches = ['prod', 'master', 'next', 'oldmaster'], repo = "openfisca-core")}
${self.repo_table(branches = ['prod', 'master', 'next', 'oldmaster'], repo = "openfisca-france")}
${self.repo_table(branches = ['master'], repo = "openfisca-tunisia")}
${self.repo_table(branches = ['prod', 'master'], repo = "openfisca-web-api")}
${self.repo_table(branches = ['prod', 'master'], repo = "openfisca-web-ui")}
</%def>


<%def name="repo_table(branches, repo)" filter="trim">
<h2 id="${repo}">${repo}</h2>
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
    <%self:travis_badge branch="${branch}" repo="${repo}" />
  </tr>
    % endfor
</table>
</%def>


<%def name="travis_badge(branch, repo)" filter="trim">
<td>${branch}</td>
<td>
  <a href="https://travis-ci.org/openfisca/${repo}/branches" rel="external" target="_blank" title="branch ${branch}">\
<img alt="travis build status" src="https://travis-ci.org/openfisca/${repo}.svg?branch=${branch}" />\
</a>
</td>
<td>
  <a href="https://github.com/openfisca/${repo}/tree/${branch}/" rel="external" target="_blank">
    ${repo}/${branch}
  </a>
</td>
</%def>
