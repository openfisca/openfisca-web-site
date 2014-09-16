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


<%inherit file="/root/france/fr/installation.mako"/>


<%def name="block_debian()" filter="trim">
    <h2 id="gnu-linux">Installation under <strong>Debian GNU/Linux</strong></h2>

    <div class="alert alert-danger">
        <strong>Caution :</strong> this installation is valid for test versions and is unstable under Debian.
    </div>

    <h3 id="noyau-gnu-linux">Installation of the OpenFisca kernel</h3>

    <ul>
        <li>
            In order to start the API, some packages are required. To install them, run the following commands:
            <pre>sudo apt-get install gettext
sudo apt-get install git
sudo apt-get install python-babel
sudo apt-get install python-dateutil
sudo apt-get install python-isodate
sudo apt-get install python-pastescript
sudo apt-get install python-pymongo
sudo apt-get install python-requests
sudo apt-get install python-setuptools
sudo apt-get install python-scipy
sudo apt-get install python-tz
sudo apt-get install python-weberror
sudo apt-get install python-webob</pre>
        </li>
    </ul>

    <h4 id="ensuite-gnu-linux">Yes. And what now?</h4>

    <ul>
        <li>
           If you want to put your files in your "Documents" folder, perform the following commands in the terminal:
            <pre>cd Documents
mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            To clone the OpenFisca files on your machine, performe the following three commands:
            <pre>git clone https://github.com/etalab/biryani.git
git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git</pre>
        </li>
        <li>To install each part of openfisca, perform the following commands in order:
            <pre>cd biryani
python setup.py compile_catalog
sudo python setup.py develop --no-deps
cd ../openfisca-core
python setup.py compile_catalog
sudo python setup.py develop --no-deps
cd ../openfisca-france
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Caution :</strong> to run your tests locally, in your test files, 
        you must replace the links simulation and legislation by your local links:
        <ul>
            <li>
                <code>http://api.openfisca.fr/api/1/simulate</code> --&gt;
                <code>http://localhost:2014/api/1/simulate</code>
            </li>
            <li>
                <code>http://api.openfisca.fr/api/1/default-legislation</code> --&gt;
                <code>http://localhost:2014/api/1/default-legislation</code>
            </li>
        </ul>
    </div>

    <h3 id="install-gnu-linux">Installation de l'API Web d'OpenFisca</h3>

    <ul>
        <li>
            To install the web API, perform the commands in order:
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            To install the API, perform the commands in order:
            <pre>cd openfisca-web-api
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-gnu-linux">Lancer le serveur</h4>

    <ul>
        <li>
            Once all these steps are completed (you should be in the <code> openfisca-web-api </ code>), run the following commands, in order:
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            To stop the server, type in the command: <kbd>ctrl + C</kbd>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Caution :</strong> to run your tests locally, in your test files,
        you must replace the links simulation and legislation by your local links :
        <ul>
            <li>
                <code>http://api.openfisca.fr/api/1/simulate</code> --&gt;
                <code>http://localhost:2014/api/1/simulate</code>
            </li>
            <li>
                <code>http://api.openfisca.fr/api/1/default-legislation</code> --&gt;
                <code>http://localhost:2014/api/1/default-legislation</code>
            </li>
        </ul>
    </div>

    <h3 id="install-ui-gnu-linux">
        Installing the user interface <small>(non necessary to use the web API)</small>
    </h3>

    <ul>
        <li>
            To install the UI, go to your openfisca folder and install the necessary packages :
            <pre>cd Documents/openfisca
sudo apt-get install python-formencode
sudo apt-get install nodejs-legacy
sudo apt-get install npm
sudo npm install -g bower
git clone https://git.gitorious.org/korma/korma.git@dev
cd korma.git@dev
sudo python setup.py develop --no-deps
cd ../
git clone https://github.com/openfisca/openfisca-web-ui.git
cd openfisca-web-ui
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
        <li>installer bower dans openfisca/openfisca-web-ui :
            <pre>cd ~/Documents/openfisca/openfisca-web-ui
bower install</pre>
        </li>
    </ul>
    <p class="alert alert-danger">
        <strong>Caution :</strong> to launch the interface's server, you should start by launching the API's server and MongoDB
        in different consoles.
    </p>
    <ul>
        <li>In a first tab, launch the API:
            <pre>cd Documents/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>In a second tab, launch MongoDB (here, installed in the openfisca folder) :
            <pre>sudo service mongodb start</pre>
        </li>
        <li>Finally, in a third tab, start the user interface server to create the indexes in the database :
            <pre>cd Documents/openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-linux">Open the interface</h4>

    <ul>
        <li>
           To open the user interface, you simply open your internet browser and follow this link: <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-gnu-linux">Installation du site OpenFisca</h3>

    <ul>
        <li>
            To install the website, open a new tab(<kbd>ctrl + shift + T</kbd>), then go in your openfisca folder
            and install the git files :
            <pre>cd Documents/openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>
    <p class="alert alert-danger">
        <strong>Caution :</strong> to start the interface's server, you must first start the API server in a different console:
    </p>
    <ul>
        <li>
            In a first tab, launch the API :
            <pre>cd Documents/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            In a second tab, launch the server's website :
            <pre>cd Documents/openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-linux">Open the webpage</h4>

    <ul>
        <li>
            To open the user interface, simply open your internet browser and follow this link : <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="block_heroku()" filter="trim">
    <h2 id="heroku">Installing with Heroku</h2>

    <ul>
        <li>
            First, sign up on <a href="https://www.heroku.com/" target="_blank">Heroku</a>
        </li>
        <li>
            Download and install <a href="https://toolbelt.heroku.com/" target="_blank">Heroku Toolbelt</a>
        </li>
        <li>
            Once installed, youu will have access to the heroku command from your shell. Connect using the e-mail address and 
            the password you used when you created you Heroku account. :
            <pre>heroku login</pre>
        </li>
        <li>
            Once installed, go in its "openfisca-web-site" folder and 
            perform the following commands to start the server on Heroku:
            <pre>heroku create --region eu --buildpack https://github.com/jdesboeufs/heroku-buildpack-openfisca
git push heroku master
heroku open</pre>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Caution :</strong> to run your tests on Heroku, 
        you must replace the simulation and legislation links in your test files by the link of the page that opened when you did
        <code>heroku open</code> :
        <ul>
            <li>
                <code>http://api.openfisca.fr/api/1/simulate</code> --&gt;
                <code>http://localhost:2014/api/1/simulate</code>
            </li>
            <li>
                <code>http://api.openfisca.fr/api/1/default-legislation</code> --&gt;
                <code>http://localhost:2014/api/1/default-legislation</code>
            </li>
        </ul>
    </div>
</%def>


<%def name="block_initial()" filter="trim">
    <h2 id="version-initiale">Installation de la version initiale d'OpenFisca pour Windows</h2>

    <div class="panel panel-warning">
        <div class="panel-heading">
            <h2 class="panel-title">Avertissement</h2>
        </div>
        <div class="panel-body">
            <p>
                The origin version of OpenFisca is now <strong>obsolete</strong>. It is no longer maintained and 
                the socio-fiscal model has not been updated for legislation since 2013.
            </p>
            <p>
               However, this version includes features that are not yet present in the new web version, 
               in particular the management of survey data. This may justify its use in some cases for demonstration purposes.
            </p>
        </div>
    </div>

    <p>
        Please read the disclaimer before you start using OpenFisca. Then click on the download link and save the
        file to your computer. Unzip the folder, open it and double-click on <code> OpenFisca.exe </ code>. 
        That's all, no installation is required. You may need to have administrator rights to run the program.
    </p>
    <p>
        For a quick tutorial, watch the video.
    </p>

    <h3>Recommended configuration</h3>

    Windows XP/Vista/7 avec 3 Go de RAM

    <h2>For GNU/Linux systems</h2>

    <p>
        Download the source code on GitHub and launch OpenFisca.pyw. You may have to add the directory 
        <code>src</code> in your <code>PYTHONPATH</code>, and to install the PyQt, Matplotlib and Numpy packages.
    </p>
    <p>
        OpenFisca was developped and tested with Python 2.7.
    </p>
</%def>


<%def name="block_mac()" filter="trim">

    <h2 id="mac">Installing with <strong>Mac OS</strong></h2>

    <h3 id="noyau-mac">Installing the OpenFisca kernel</h3>

    <ul>
        <li>
            Install <a href="http://brew.sh/index_fr.html">Homebrew</a>
        </li>
        <li>
            To launch the API, some packages are necessary. To install them, 
            Afin de pouvoir lancer l'API, certain paquets sont nécessaires, run the following commands :
            <pre>brew install git
brew install gfortran
brew install mongodb
brew install nodejs
sudo pip install babel
sudo pip install isodate
sudo pip install pastescript
sudo pip install pymongo
sudo pip install python-dateutil
sudo pip install python-gettext
sudo pip install python-magic
sudo pip install python-setuptools
sudo pip install scipy
sudo pip install numpy
sudo pip install requests
sudo pip install webob
sudo pip install weberror</pre>
        </li>
    </ul>

    <h4 id="ensuite-gnu-mac">Yes. And what now ?</h4>

    <ul>
        <li>
            If you want to put your files in the root, perform the following command in the terminal:
            <pre>mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            To clone the openfisca files on your machine, type in the following three commands:
            <pre>git clone https://github.com/etalab/biryani.git
git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git</pre>
        </li>
        <li>
            To install each part of openfisca, perform the following commands in order:
            <pre>cd biryani
python setup.py compile_catalog
sudo python setup.py develop --no-deps
cd ../openfisca-core
python setup.py compile_catalog
sudo python setup.py develop --no-deps
cd ../openfisca-france
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h3 id="install-mac">Installing OpenFisca's web API</h3>

    <ul>
        <li>
            To clone the files from the API on your machine, use the following command:
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            To install the API, perform the commands in order:
            <pre>cd ../openfisca-web-api
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-mac">Launch the server</h4>

    <ul>
        <li>
            Once all these steps are finished (you should be in the "openfisca-web-api" folder), run the following command in order :
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            To stop the server, enter <kbd>ctrl + C</kbd> in the command
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Caution :</strong> to run your tests locally, you must replace the 
        simulation and legislation linkse in your test files, by your local links:
        <ul>
            <li>
                <code>http://api.openfisca.fr/api/1/simulate</code> --&gt;
                <code>http://localhost:2014/api/1/simulate</code>
            </li>
            <li>
                <code>http://api.openfisca.fr/api/1/default-legislation</code> --&gt;
                <code>http://localhost:2014/api/1/default-legislation</code>
            </li>
        </ul>
    </div>

    <h3 id="install-ui-mac">
         Installing the User Interface <small> (not necessary to run the Web API) </ small>
    </h3>

    <ul>
        <li>
            To install the UI, open a new tab (<kbd>ctrl + shift + T</kbd>), go into its 
            openfisca folder and install the essential packages :
            <pre>cd /openfisca
sudo pip install python-formencode
sudo pip install nodejs-legacy
sudo pip install npm
npm install -g bower
git clone https://git.gitorious.org/korma/korma.git@dev
cd korma.git@dev
sudo python setup.py develop --no-deps
cd ../
git clone https://github.com/openfisca/openfisca-web-ui.git
cd openfisca-web-ui
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
        <li>
            Installer bower dans openfisca/openfisca-web-ui :
            <pre>cd /openfisca/openfisca-web-ui
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Caution :</strong> to start the server interface, you must first start the API's servers and MongoDB in different consoles:
    </p>
    <ul>
        <li>
            Start by launching the API in a first tab :
            <pre>cd /openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            In a second tab, launch MongoDB (here, installed in the openfisca folder) :
            <pre>mongod</pre>
        </li>
        <li>
            Finally, in a third tab, start the user interface server to create the indexes in the database : 
            <pre>cd /openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-mac">Open the interface</h4>

    <ul>
        <li>
            To open the user interface, simply open your internet browser and follow this link : <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-mac">Installation du site OpenFisca</h3>

    <ul>
        <li>
            To install the website, open a new tab (<kbd>ctrl + shift + T</kbd>), go in your openfisca folder and install the git files :
            <pre>cd /openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Caution :</strong> to start the server interface, you must first start the API's server in a different console:
    </p>
    <ul>
        <li>
            In a first tab, launch the API :
            <pre>cd /openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            In a second tab, launch the website's server :
            <pre>cd /openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-mac">Open the webpage</h4>

    <ul>
        <li>
            To open the user interface, just open you web browser and follow this link : <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="block_windows()" filter="trim">
    <h2 id="windows">Installing under <strong>Windows</strong></h2>

    <h3 id="noyau-windows">Installing the OpenFisca kernel</h3>

    <ul>
        <li>
            Install <a href="https://www.python.org/download/releases/2.7.6/">Python 2.7.6</a>
        </li>
        <li>
            Install <a href="git-scm.com/download/win">Git</a>, open the .exe file and select default answers except for
            "adjusting yout PATH environment", and select "run Git from the Windows Command Prompt"
        </li>
        <li>
            Download <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools" target="_blank">"Setuptools"</a>
            in their version for Python 2.7
        </li>
    </ul>

    <h4 id="ensuite-windows">Yes. And now what ?</h4>

    <ul>
        <li>
            First, open the Windows control, the simplest being to press : 
            <kbd>Windows + R</kbd>, de taper <kbd>cmd</kbd> puis ok.
        </li>
        <li>
            If you want to put your files on the desktop, perform the following commands in the
            <abbr title="windows command prompt">CMD</abbr> :
            <pre>cd Desktop
mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            To clone openfisca files on your machine, do the following three commands:
            <pre>git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git
git clone https://github.com/etalab/biryani.git</pre>
        </li>
        <li>
            To install each part of openfisca, perform the following commands in order:
            <pre>pip install python-gettext
pip install PasteScript
cd biryani
python setup.py compile_catalog
sudo python setup.py develop --no-deps
cd ../openfisca-core
python setup.py compile_catalog
python setup.py develop --no-deps
cd ../openfisca-france
python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h3 id="install-windows">Installation de l'API Web d'OpenFisca</h3>

    <ul>
        <li>
            To clone the files from the API on your machine, use the following command:
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            To install the API, perform the commands in order:
            <pre>cd ../openfisca-web-api
python setup.py compile_catalog
python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-windows">Launch the server</h4>

    <ul>
        <li>
           Once all these steps are finished (you should be in the "openfisca-web-api" folder), run the following command in order:
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            To stop the server, type in <kbd>ctrl + C</kbd>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Caution :</strong> to run your tests locally, you must replac simulation and legislation links 
        in your test files, by your local links :
        <ul>
            <li>
                <code>http://api.openfisca.fr/api/1/simulate</code> --&gt;
                <code>http://localhost:2014/api/1/simulate</code>
            </li>
            <li>
                <code>http://api.openfisca.fr/api/1/default-legislation</code> --&gt;
                <code>http://localhost:2014/api/1/default-legislation</code>
            </li>
        </ul>
    </div>

    <h3 id="install-ui-windows">
        Installation of the User Interface <small>(non necessary to run the web API)</small>
    </h3>
    <ul>
        <li>
           To install the UI, open a new command(<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd> -&gt;
            OK) and go in your openfisca file :
            <pre>cd Desktop/openfisca
git clone https://git.gitorious.org/korma/korma.git@dev
cd korma.git@dev
python setup.py develop --no-deps
cd ../
git clone https://github.com/openfisca/openfisca-web-ui.git
cd openfisca-web-ui
python setup.py compile_catalog
python setup.py develop --no-deps
pip install FormEncode</pre>
        </li>
        <li>
            Then download <a href="http://nodejs.org/download/">nodejs</a> and execute the .exe file
        </li>
        <li>
           Once the installation is complete, download
            <a href="https://www.mongodb.org/downloads">MongoDB</a> and install it
        </li>
        <li>
                You'll might have to restart your computer in order to take into account certain parameters        </li>
        <li>
            Install bower :
            <pre>npm install -g bower</pre>
        </li>
        <li>
            Install bower dans openfisca/openfisca-web-ui :
            <pre>cd Desktop/openfisca/openfisca-web-ui
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Caution :</strong> to start the server interface, 
        you must first start the API's server and MongoDB in different consoles:
    </p>
    <ul>
        <li>
            First, in a terminal, run the API:
            <pre>cd Desktop/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Then, in a second console, run MongoDB (here, installed in the openfisca folder)
            <pre>cd Desktop/openfisca/mongodb/bin
mongod.exe</pre>
        </li>
        <li>
            Finally, in a third terminal, run the user interface server to create the indexes in the database :
            <pre>cd Desktop/openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-windows">Open the interface</h4>

    <ul>
        <li>
           To open the user interface, simply open your internet browser and follow this link: <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-windows">Installing OpenFisca website</h3>

    <ul>
        <li>
            To install the website, open a new command (<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd>
            -&gt; OK), go in your openfisca folder and install the git files :
            <pre>cd Desktop/openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Caution :</strong> to start the interface server, you must first start the API server in a different console :
    </p>

    <ul>
        <li>
            First, in a first terminal, run the API :
            <pre>cd Desktop/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
           Then, in a second console, start the server :
            <pre>cd Desktop/openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-windows">Open the website</h4>

    <ul>
        <li>
            To open the user interface, simply open your internet browser 
            and follow this link: <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="h1_content()" filter="trim">
Installing OpenFisca
</%def>


<%def name="nav_content()" filter="trim">
            <li>
                <a href="#gnu-linux">Installing with Debian GNU/Linux</a>
                <ul class="nav">
                    <li><a href="#noyau-gnu-linux">OpenFisca kernel</a></li>
                    <li><a href="#install-gnu-linux">OpenFisca web API</a></li>
                    <li><a href="#install-ui-gnu-linux">User Interface</a></li>
                    <li><a href="#install-site-gnu-linux">OpenFisca Website</a></li>
                </ul>
            </li>
            <li>
                <a href="#heroku">Installing with Heroku</a>
            </li>
            <li>
                <a href="#mac">Installing with Mac OS</a>
                <ul class="nav">
                    <li><a href="#noyau-mac">OpenFisca kernel</a></li>
                    <li><a href="#install-mac">OpenFisca web API</a></li>
                    <li><a href="#install-ui-mac">User Interface</a></li>
                    <li><a href="#install-site-mac">Site Web OpenFisca</a></li>
                </ul>
            </li>
            <li>
                <a href="#windows">Installation Windows</a>
                <ul class="nav">
                    <li><a href="#noyau-windows">Noyau OpenFisca</a></li>
                    <li><a href="#install-windows">OpenFisca web API</a></li>
                    <li><a href="#install-ui-windows">User Interface</a></li>
                    <li><a href="#install-site-windows">OpenFisca Website</a></li>
                </ul>
            </li>
            <li>
                <a href="#version-initiale">Installing the original version</a>
            </li>
</%def>


<%def name="page_content()" filter="trim">
    <div role="main">
        <%self:block_debian/>
        <hr>
        <%self:block_heroku/>
        <hr>
        <%self:block_mac/>
        <hr>
        <%self:block_windows/>
        <hr>
        <%self:block_initial/>
    </div>
</%def>
