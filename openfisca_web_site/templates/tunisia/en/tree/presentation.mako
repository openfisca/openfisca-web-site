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


<%inherit file="/france/fr/tree/presentation.mako"/>


<%def name="h1_content()" filter="trim">Présentation</%def>


<%def name="page_content()" filter="trim">
        <h2>What is OpenFisca ?</h2>

        <p>
            OpenFisca is an open microsimulation software of French socio-fiscal system. It allows users to simply
            calculate many social benefits and taxes paid by households and simulate
            the impact of reforms on their budget.
        </p>
        <p>
            It is an educational tool intended to help citizens better
            understand the socio-fiscal system.
        </p>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <h2 class="panel-title">Disclaimer</h2>
            </div>
            <div class="panel-body">
                <p>OpenFisca calculates the amounts of payroll taxes, taxes, and benefits using:</p>
                <ul>
                    <li>the household's characteristic, as indicated by the user
                    </li>
                    <li>a <strong>simplified</strong>
                    and <strong>approximate</strong> model of the socio-fiscal legislation
                    </li>
                </ul>
                <p>These amounts are given only as indicators and may
                differ from those determined by various authorities
                for your real situation. The results cannot be held against the administration,
                the Caf or more generally, against any organization
                involved in the calculation of taxes and benefits.
                In fact, your family situation and / or resources may change or may not have been
                taken into account in the simulation. Some simplifying hypothesis may have been made.
                </p>
            </div>
        </div>

        <h2>History of OpenFisca</h2>

        <p>
          The development of OpenFisca began in May 2011 at
        the <abbr title = "Centre d'analyse stratégique"> CAS
        </ abbr>, renamed <abbr title = "Commissariat général à la
        stratégie et à la prospective"> CGSP </ abbr> in spring 2013,
        with the support of the <abbr title = "Institut d'économie
        publique"> IDEP </ abbr>. The source code has been released
        under a free license in November 2011. OpenFisca was
        originally developed as an integrated desktop application (Qt)
        with a Python API.
        </p>

        <p>
            The OpenFisca engine is generic. It is therefore
            completely independent of the socio-tax legislation. It is
            therefore possible to simulate any socio-fiscal
            system. The Tunisian version of OpenFisca have been is
            currently under development as well. The Tunisian version
            is less advanced than the French version. But this is only
            due to a shortage in manpower to enter and update the
            Tunisian socio-fiscal legislation. Feel free to joins us.
        </p>

        <p>
            When Etalab started being implicated in the development of
            OpenFisca, in the early 2014, it was decided to:
        </p>
        <ul>
            <li>
                separate the simulator's engine and its user interface (Qt)
            </li>
            <li>
                offer a <strong>web API</strong>, in addition to the Python API,
                and favor the first it over the latter.
            </li>
            <li>
                demonstrate the value of Web API by developing sample
                applications including a web interface to simulate
                personal cases
            </li>
            <li>

               propose a <strong> public access to this web API </ strong>,
               open to all : administrations, researchers, citizens, etc.
            </li>
        </ul>
        <p>
            Since then, the software is being developed extensively by Etalab.
            Meanwhile the economic model is being improved and the socio-fiscal legislation updated by the
            <abbr title="Commissariat général à la stratégie et à la prospective">CGSP</abbr>,
            with the help of the <abbr title="Institut d'économie
            publique">IDEP</abbr> and the <abbr title="Institut des
            politiques publiques">IPP</abbr>.
        </p>
        <p>
            As of now (March 2014), the Qt version is no longer maintained and
            only the web version is being developped.
        </p>


</%def>
