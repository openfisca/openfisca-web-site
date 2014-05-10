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
import urlparse

from openfisca_web_site import conf, urls
%>


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Graphe des formules socio-fiscales
</%def>


<%def name="page_content()" filter="trim">
        <p>Graphe des dépendances des formules socio-fiscales, telles qu'implémentées dans OpenFisca :</p>
        <div id="graph" style="height: 600px; width: 100%"></div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script src="${urls.get_url(ctx, u'/bower/vis/dist/vis.min.js')}"></script>
    <script>
$.ajax(${urlparse.urljoin(conf['api.url'], '/api/1/graph') | n, js}, {
    data: {
        variable: 'revdisp'
    },
    dataType: 'json',
    xhrFields: {
        withCredentials: true
    }
})
.done(function (data, textStatus, jqXHR) {
    var graph = new vis.Graph($('#graph').get(0), {
            nodes: data.nodes,
            edges: data.edges,
        }, {
            edges: {
                style: 'arrow-center'
            },
##            height: '600px',
##            hierarchicalLayout: {
##                direction: 'LR',
##                nodeSpacing: 500
##            },
            nodes: {
                shape: 'dot',
            },
            stabilize: false,
##            width: '100%'
        });
})
.fail(function(jqXHR, textStatus, errorThrown) {
    console.log('fail');
    console.log(jqXHR);
    console.log(textStatus);
    console.log(errorThrown);
});
    </script>
</%def>
