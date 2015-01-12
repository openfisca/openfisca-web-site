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
from openfisca_web_site import conf, urls
%>


<%inherit file="/france/fr/tree/presentation.mako"/>


<%def name="h1_content()" filter="trim">Presentation</%def>


<%def name="page_content()" filter="trim">
        <h2>What is OpenFisca?</h2>

        <p>
            OpenFisca is an open microsimulation software of French tax-benefit system. It allows users to simply
            calculate many social benefits and taxes paid by households and simulate
            the impact of reforms on their budget.
            It is an educational tool intended to help citizens better understand the tax-benefit system.
        </p>

        <p>
            The OpenFisca engine is completely independent of the tax-benefit system,
            it is therefore possible to simulate any country.
        </p>

        <p>
            The impact of any modification in the legislation or formulas can also be computed via reforms.
            <a href="${urls.get_url(ctx, 'reforms')}">Example reforms</a>
        </p>

        <p>
            When plugged on a survey, OpenFisca can also compute the budgetary consequences
            of a reform and its distributional impact.
        </p>

        <p>
            For now the main supported country is
            <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">France</a>.
            The current version implements a large set of taxes, social benefits
            and housing provision for France for the last 10 years.
            Support for
            <a href="https://github.com/openfisca/openfisca-tunisia" rel="external" target="_blank">Tunisia</a>
            is more experimental since the modelization of its tax-benefit system is less advanced (January 2015).
            But this is only due to a shortage in manpower to enter and update the Tunisian tax-benefit legislation.
        </p>

        <div class="alert alert-warning">
            <h4>Disclaimer</h4>
            <p>OpenFisca calculates the amounts of payroll taxes, taxes, and benefits using:</p>
            <ul>
                <li>the household's characteristic, as indicated by the user</li>
                <li>a <em>simplified</em> and <em>approximate</em> model of the tax-benefit legislation</li>
            </ul>
            <p>
                These amounts are given only as indicators and may differ from those determined by various authorities
                for your real situation. The results cannot be held against the administration,
                or more generally, against any organization involved in the calculation of taxes and benefits.
            </p>
            <p>
                In fact, your family situation and/or resources or those of a member of your family may change or
                may not have been taken into account in the simulation. Some simplifying hypothesis may have been made.
            </p>
        </div>

        <h2>Getting started</h2>

        <p>
            The <a href="${conf['urls.ui']}">web user interface</a> allows the user to compute and display interactively
            all these taxes and benefits for any type of household, and play with reforms.
        </p>

        <h2>History of OpenFisca</h2>

        <p>
            The development of OpenFisca began in May 2011 at the <abbr title="Centre d'analyse stratégique">CAS</abbr>,
            renamed <abbr title="Commissariat général à la stratégie et à la prospective">CGSP</abbr> in spring 2013,
            with the support of the <abbr title="Institut d'économie publique">IDEP</abbr> since May 2011.
            The source code has been released under a free license in November 2011.
            OpenFisca was originally developed as a desktop application
            (using <a href="http://qt-project.org/" rel="external" target="_blank">Qt</a> library)
            with a Python API.
        </p>
        <p>
            In the early 2014, when <a href="https://www.etalab.gouv.fr/" rel="external" target="_blank">Etalab</a>
            started being implicated in the development of OpenFisca, it was decided to:
        </p>
        <ul>
            <li>
                separate the simulator's engine from its desktop user interface
            </li>
            <li>
                offer a <a href="${urls.get_url(ctx, 'documentation', 'api')}">web API</a>
                in addition to the Python API and favor the first it over the latter
            </li>
            <li>
                demonstrate the value of the web API by developing sample applications including
                a web interface to simulate personal cases
            </li>
            <li>
               propose a <em>public access to this web API</em>,
               open to all: administrations, researchers, citizens, etc.
            </li>
        </ul>
        <p>
            Since then, the software is being developed extensively by
            <a href="https://www.etalab.gouv.fr/" rel="external" target="_blank">Etalab</a>.
            Meanwhile the economic model is being improved and the tax-benefit legislation updated by the
            <abbr title="Commissariat général à la stratégie et à la prospective">CGSP</abbr>,
            with the help of the <abbr title="Institut d'économie publique">IDEP</abbr> and the
            <abbr title="Institut des politiques publiques">IPP</abbr>.
        </p>
        <p>
            As of now (March 2014), the Qt version is no longer maintained and only the web version is being developped.
        </p>
</%def>
