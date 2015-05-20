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
from openfisca_web_site import urls
%>


<%inherit file="/page-avec-nav.mako"/>


<%def name="h1_content()" filter="trim">
Installing OpenFisca
</%def>


<%def name="installing_openfisca_core()" filter="trim">
        <h3 id="installing-openfisca-core">Installing the Core</h3>

        <p>
            Clone the OpenFisca-Core Git repository on your machine and install the Python package.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-core.git
cd openfisca-core
pip install --editable . --user
python setup.py compile_catalog\
</pre>

        <p>
            Once OpenFisca-Core is installed, the next step is to install the tax-benefit system of a country.
        </p>
</%def>


<%def name="installing_openfisca_france()" filter="trim">
        <h3 id="installing-openfisca-france">Installing the Tax-Benefit System</h3>

        <p>
            For the purpose of this documentation, we are going to install the
            <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">
                french tax-benefit system
            </a>
            but you can also install the
            <a href="https://github.com/openfisca/openfisca-tunisia" rel="external" target="_blank">tunisian one</a>.
        </p>

        <p>
            Clone the OpenFisca-France Git repository on your machine and install the Python package.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-france.git
cd openfisca-france
pip install --editable .[tests] --user
python setup.py compile_catalog\
</pre>
</%def>


<%def name="installing_prerequisites()" filter="trim">
        <h3 id="installing-prerequisites">Installing prerequisites</h3>

        <p>
            Developing with OpenFisca requires some prerequisite softwares to be installed:
            the <a href="http://www.python.org/" rel="external" target="_blank">Python</a> programming language,
            the source code management tool named
            <a href="http://www.git-scm.com/" rel="external" target="_blank">Git</a>,
            and some Python pre-compiled packages for scientific computing.
        </p>

        <p>
            Each software has its own installation procedure depending on the target operating system.
            Please click on the panel below corresponding to your operating system.
        </p>

        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingDebian">
                    <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseDebian" \
aria-expanded="true" aria-controls="collapseDebian">
                            Debian GNU/Linux (or Ubuntu)
                        </a>
                    </h4>
                </div>
                <div id="collapseDebian" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingDebian">
                    <div class="panel-body">
                        <pre>\
su -
[type your root password]
apt-get install gettext
apt-get install git
apt-get install python-numpy
apt-get install python-pip
apt-get install python-pymongo
apt-get install python-scipy\
</pre>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingMacOsX">
                    <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseMacOsX" \
aria-expanded="false" aria-controls="collapseMacOsX">
                            Mac OS X
                        </a>
                    </h4>
                </div>
                <div id="collapseMacOsX" class="panel-collapse collapse" role="tabpanel" \
aria-labelledby="headingMacOsX">
                    <div class="panel-body">
                        <p>TODO</p>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingWindows">
                    <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseWindows" \
aria-expanded="false" aria-controls="collapseWindows">
                            Microsoft Windows
                        </a>
                    </h4>
                </div>
                <div id="collapseWindows" class="panel-collapse collapse" role="tabpanel" \
aria-labelledby="headingWindows">
                    <div class="panel-body">
                        <p>
                            Download the pre-compiled Python packages here, corresponding to your Python version
                            (check with <samp>python --version</samp>) and CPU architecture (might be amd64):
                        </p>
                        <ul>
                            <li>
                                <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools" rel="external" \
target="_blank">
                                    Setuptools
                                </a>
                            </li>
                            <li>
                                <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#numpy" rel="external" \
target="_blank">
                                    NumPy
                                </a>
                            </li>
                            <li>
                                <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#scipy" rel="external" \
target="_blank">
                                    SciPy
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <p>From now you should be able to open a terminal window and type commands.</p>

        <p>
          Create a directory named <samp>openfisca</samp> which will contain the different Git repository clones.
          Here we choose to create it directly in your home directory
          (reachable with the <samp>cd</samp> command without arguments) but you can choose any other place.
        </p>

        <pre>\
cd
mkdir openfisca
cd openfisca\
</pre>
</%def>



<%def name="installing_openfisca_web_api()" filter="trim">
        <h3 id="installing-openfisca-web-api">Installing the Web API</h3>

        <div class="alert alert-info">
            <strong>Note:</strong> the API is hosted online at <samp>http://api.openfisca.fr/</samp>
            (<a href="${urls.get_url(ctx, 'api')}">API documentation</a>). You do not need to install it to use it,
            except if you'd like to hack on its code, or host an instance of the API on your server.
        </div>

        <p>
          Clone the OpenFisca-Web-API Git repository on your machine and install the Python package.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-web-api.git
cd openfisca-web-api
pip install --editable .[dev] --user
python setup.py compile_catalog\
</pre>

        <p>Run the server:</p>

        <pre>paster serve --reload development-france.ini</pre>

        <p>To stop the server, type <kbd>Ctrl-C</kbd> like for any other command.</p>

        <p>
          To test, open the following URL in your browser:
          <a href="http://localhost:2000/" rel="external" target="_blank">http://localhost:2000/</a>
          (2000 is the port number defined in the <samp>development-france.ini</samp> config file).
          You should see a JSON object explaining that the path is not found, like this:
        </p>

        <pre>{"apiVersion": "1.0", "error": {"message": "Path not found: /", "code": 404}}</pre>

        <div class="alert alert-info">
            <strong>Note:</strong> the error is normal, it simply says that the URL path <samp>/</samp> does not
            correspond to any endpoint.
        </div>

        <p>
            Please consult the <a href="${urls.get_url(ctx, 'api')}">API documentation</a>
            to know how to use it, but replace each occurence of
            the domain <samp>api.openfisca.fr</samp> by <samp>localhost:2000</samp>.
        </p>
</%def>


<%def name="installing_openfisca_web_site()" filter="trim">
        <h3 id="installing-openfisca-web-site">Installing the Web Site</h3>

        <div class="alert alert-info">
            <strong>Note:</strong> the web site is hosted online at
            <a href="${urls.get_full_url(ctx)}" rel="external" target="_blank">${urls.get_full_url(ctx)}</a>
            (you are currently reading it!).
            You shouldn't need to install it, except if you'd like to hack on its code,
            or host an instance of the web site on your server, which is more than unlikely.
        </div>

        <p>
            The web site is a standalone web application. Please consult its own documentation to install it.
            <a href="https://github.com/openfisca/openfisca-web-site" rel="external" target="_blank">
              OpenFisca-Web-Site documentation
            </a>
        </p>
</%def>


<%def name="installing_openfisca_web_ui()" filter="trim">
        <h3 id="installing-openfisca-web-ui">Installing the User Interface</h3>

        <div class="alert alert-info">
            <strong>Note:</strong> the user interface is hosted online at
            <a href="http://ui.openfisca.fr/" rel="external" target="_blank">http://ui.openfisca.fr/</a>.
            You do not need to install it to use it, except if you'd like to hack on its code,
            or host an instance of the user interface on your server.
        </div>

        <p>
            The user interface is a standalone web application. Please consult its own documentation to install it.
            <a href="https://github.com/openfisca/openfisca-web-ui" rel="external" target="_blank">
              OpenFisca-Web-UI documentation
            </a>
        </p>
</%def>


<%def name="nav_content()" filter="trim">
            <li><a href="#installing-prerequisites">Prerequisites</a></li>
            <li><a href="#installing-openfisca-core">Core</a></li>
            <li><a href="#installing-openfisca-france">Tax-Benefit System</a></li>
            <li><a href="#installing-openfisca-web-api">Web API</a></li>
            <li><a href="#installing-openfisca-web-ui">User Interface</a></li>
            <li><a href="#installing-openfisca-web-site">Web Site</a></li>
</%def>


<%def name="page_content()" filter="trim">
    <div role="main">
        <div class="alert alert-info">
            <strong>Note:</strong> this installation procedure is intended for developers who want to install and run
            OpenFisca on their computer, and modify the source code.
            Operating systems targeted are, among others, GNU/Linux distributions, Mac OS X and Microsoft Windows.
        </div>
        <%self:installing_prerequisites/>
        <%self:installing_openfisca_core/>
        <%self:installing_openfisca_france/>
        <%self:installing_openfisca_web_api/>
        <%self:installing_openfisca_web_ui/>
        <%self:installing_openfisca_web_site/>
    </div>
</%def>
