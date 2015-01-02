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
import itertools

import lxml.html
%>

<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Actualités
</%def>


<%def name="last_articles(count = 10)" filter="trim">
    % for article in itertools.islice(node.parent.iter_latest_articles(), count):
        % if not loop.first:
        <hr>
        % endif
        <article id="${article['hash']}">
        % if article.get('title_url') is None:
            <h3>${article['title']}</h3>
        % else:
            <a href="${article['title_url']}"><h3>${article['title']}</h3></a>
        % endif
        % for child_element in article['element']:
            ${lxml.html.tostring(child_element, encoding = unicode) | n}
        % endfor
        </article>
    % endfor
</%def>


<%def name="page_content()" filter="trim">
        <%self:last_articles/>
</%def>
