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

<%def name="body_attributes()" filter="trim">
data-spy="scroll" data-target="#sommaire"
</%def>

<%def name="h1_content()" filter="trim">
Installation d'OpenFisca
</%def>


<%def name="page_content()" filter="trim">
<div class="row">


##Installation Debian GNU/Linux


    <div class="col-md-9" role="main">
    <h2 id="gnu-linux">Installation sous  <strong>Debian GNU/Linux</strong></h2>
    <h3 id="noyau-gnu-linux">Installation du noyau d'OpenFisca</h3>
    <ul>
        <li>Afin de pouvoir lancer l'API, certain paquets sont nécessaires, pour les installer, lancer les commandes suivantes :
            <pre># apt-get install gettext
# apt-get install git
# apt-get install python-babel
# apt-get install python-dateutil
# apt-get install python-isodate
# apt-get install python-pandas
# apt-get install python-pastescript
# apt-get install python-pymongo
# apt-get install python-setuptools
# apt-get install python-scipy
# apt-get install python-requests
# apt-get install python-weberror</pre></li>
    </ul>
    <h4 id="ensuite-gnu-linux">Oui, mais ensuite ?</h4>
    <ul>
        <li>Si vous voulez mettre vos fichiers dans "Documents", effectuer les commandes suivantes dans le terminal :</li>
            <pre>$ cd Documents
$ mkdir openfisca
$ cd openfisca</pre>
        <li>Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :</li>
            <pre>$ git clone https://github.com/etalab/biryani.git
$ git clone http://github.com/openfisca/openfisca-core.git
$ git clone http://github.com/openfisca/openfisca-france.git</pre>
        <li>Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :</li>
            <pre>$ cd biryani
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ cd openfisca-core
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ cd ../openfisca-france
# python setup.py develop --no-deps</pre>
    </ul>
    <h3 id="install-gnu-linux">Installation de l'API Web d'OpenFisca</h3>
    <ul>
        <li>Pour cloner les fichiers de l'api sur votre machine, effectuez la commande suivante :</li>
            <pre>$ git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        <li>Afin d'installer l'API, effectuez les commandes dans l'ordre :</li>
            <pre>$ cd ../openfisca-web-api
$ python setup.py compile_catalog
# python setup.py develop --no-deps</pre>
    </ul>
    <h4 id="serveur-gnu-linux">Lancer le serveur</h4>
    <ul>
        <li>Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez dans le dossier "openfisca-web-api" lancer la commande suivante :</li>
            <pre>$ paster serve --reload development.ini</pre>
        <li>Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd></li>
    </ul>
    <div class="alert alert-danger">ATTENTION : pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les liens de simulation et de législation par vos liens locaux :
        <ul>
            <li>http://api.openfisca.fr/api/1/simulate  --&gt;  http://localhost:2014/api/1/simulate</li>
            <li>http://api.openfisca.fr/api/1/default-legislation  --&gt;  http://localhost:2014/api/1/default-legislation</li>
        </ul>
    </div>
    <h3 id="install-ui-gnu-linux">Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small></h3>
    <ul>
        <li>Pour installer l'UI, il faut ouvrir un nouvel onglet (<kbd>ctrl + shift + T</kbd>), aller dans son dossier openfisca et installer les paquets essentiels :
            <pre>$ cd Documents/openfisca
# apt-get install python-formencode
# apt-get install nodejs-legacy
# apt-get install npm
$ npm install -g bower
$ git clone https://git.gitorious.org/korma/korma.git@dev
$ cd korma.git@dev
# python setup.py develop --no-deps
$ cd ../
$ git clone https://github.com/openfisca/openfisca-web-ui.git
$ cd openfisca-web-ui
$ python setup.py compile_catalog
# python setup.py develop --no-deps
$ ./openfisca_web_ui/scripts/setup.py development.ini #création des index dans la base de donnée</pre></li>
        <li>installer bower dans openfisca/openfisca-web-ui :
            <pre>$ cd Documents/openfisca/openfisca-web-ui
$ bower install</pre>
        </li>
    </ul>
    <p class="alert alert-danger">ATTENTION : pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de l'api et MongoDB dans des consoles différentes :</p>
    <ul>
        <li>Tout d'abord, dans un premier onglet, lancer l'API :
            <pre>$ cd Documents/openfisca/openfisca-web-api
$ paster serve --reload development.ini</pre></li>
        <li>Enusite, dans un deuxième onglet, lancer MongoDB (ici installé dans le dossier openfisca) :
            <pre># service mongodb start</pre></li>
        <li>Enfin, dans un troisième onglet, lancer le serveur de l'Interface utilisateur :
            <pre>$ cd Documents/openfisca/openfisca-web-ui
$ paster serve --reload development.ini</pre></li>
    </ul>
    <h4 id="interface-linux">Ouvrir l'interface</h4>
    <ul>
        <li>Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à l'adresse du lien suivant : <kbd>http://localhost:2015</kbd></li>
    </ul>
    <hr>


##Installation Windows


    <h2 id="windows">Installation sous <strong>Windows</strong></h2>
    <h3 id="noyau-windows">Installation du noyau d'OpenFisca</h3>
    <ul>
        <li>Installer <a href="https://www.python.org/download/releases/2.7.6/">Python 2.7.6</a></li>
        <li>Installer <a href="git-scm.com/download/win">Git</a>, ouvrir le .exe et choisissez tout par defaut sauf "adjusting yout PATH environent" et selectionnez "run Git from the Windows Command Prompt"</li>
        <li>Télécharger les <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools">outils python</a> dans leur version pour Python 2.7</li>
    </ul>
    <h4 id="ensuite-windows">Oui, mais ensuite ?</h4>
    <ul>
        <li>Tout d'abord, il faut ouvrir la commande Windows, le plus simple étant de faire la touche <kbd>Windows + R</kbd>, de taper <kbd>cmd</kbd> puis ok.
        </li><li>Si vous voulez mettre vos fichiers sur le bureau, effectuer les commandes suivantes dans la <abbr title="windows command prompt">CMD</abbr> :</li>
            <pre>$ cd Desktop
$ mkdir openfisca
$ cd openfisca</pre>
        <li>Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :</li>
            <pre>$ git clone http://github.com/openfisca/openfisca-core.git
$ git clone http://github.com/openfisca/openfisca-france.git
$ git clone https://github.com/etalab/biryani.git</pre>
        <li>Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :</li>
            <pre>$ pip install python gettext
$ pip install PasteScript
$ cd openfisca-core
$ python setup.py compile_catalog
$ python setup.py install
$ cd ../openfisca-france
$ python setup.py install</pre>
    </ul>



    <h3 id="install-windows">Installation de l'API Web d'OpenFisca</h3>
    <ul>
        <li>Pour cloner les fichiers de l'api sur votre machine, effectuez la commande suivante :</li>
            <pre>$ git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        <li>Afin d'installer l'API, effectuez les commandes dans l'ordre :</li>
            <pre>$ git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        <li>Afin d'installer l'API, effectuez les commandes dans l'ordre :</li>
            <pre>$ cd ../openfisca-web-api
$ python setup.py compile_catalog
$ python setup.py install</pre>
    </ul>
    <h4 id="serveur-windows">Lancer le serveur</h4>
    <ul>
        <li>Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez dans le dossier "openfisca-web-api" lancer la commande suivante :</li>
            <pre>$ paster serve --reload development.ini</pre>
        <li>Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd></li>
    </ul>
    <div class="alert alert-danger">ATTENTION : pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les liens de simulation et de législation par vos liens locaux :
        <ul>
            <li>http://api.openfisca.fr/api/1/simulate  --&gt;  http://localhost:2014/api/1/simulate</li>
            <li>http://api.openfisca.fr/api/1/default-legislation  --&gt;  http://localhost:2014/api/1/default-legislation</li>
        </ul>
    </div>
    <h3 id="install-ui-windows">Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small></h3>
    <ul>
        <li>Pour installer l'UI, il faut ouvrir une nouvelle commande (<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd> -&gt; OK) et aller dans son dossier openfisca :
            <pre>$ cd Desktop/openfisca
$ git clone https://git.gitorious.org/korma/korma.git@dev
$ cd korma.git@dev
$ python setup.py install
$ cd ../
$ git clone https://github.com/openfisca/openfisca-web-ui.git
$ cd openfisca-web-ui
$ python setup.py compile_catalog
$ python setup.py install
$ ./openfisca_web_ui/scripts/setup.py development.ini #création des index dans la base de donnée
$ pip install FormEncode</pre></li>
        <li>Télécharger ensuite <a href="http://nodejs.org/download/">nodejs</a> et executer le .exe</li>
        <li> une fois l'installation terminée, il faut télécharger <a href="https://www.mongodb.org/downloads">MongoDB</a> et l'installer</li>
        <li>Vous aurez surement besoin de redémmarer votre machine afin de prendre certains paramètres en compte</li>
        <li>installer bower :
            <pre>$ npm install bower</pre></li>
        <li>installer bower dans openfisca/openfisca-web-ui :
            <pre>$ cd Desktop/openfisca/openfisca-web-ui
$ bower install</pre></li>
    </ul>
    <p class="alert alert-danger">ATTENTION : pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de l'api et MongoDB dans des consoles différentes :</p>
    <ul>
        <li>Tout d'abord, dans une première console, lancer l'API :
            <pre>$ cd Desktop/openfisca/openfisca-web-api
$ paster serve --reload development.ini</pre></li>
        <li>Enusite, dans une deuxième console, lancer MongoDB (ici installé dans le dossier openfisca) :
            <pre>$ cd Desktop/openfisca/mongodb/bin
$ mongod.exe</pre></li>
        <li>Enfin, dans une troisième console, lancer le serveur de l'Interface utilisateur :
            <pre>$ cd Desktop/openfisca/openfisca-web-ui
$ paster serve --reload development.ini</pre></li>
    </ul>
    <h4 id="interface-windows">Ouvrir l'interface</h4>
    <ul>
        <li>Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à l'adresse du lien suivant : <kbd>http://localhost:2015</kbd></li>
    </ul>
    <hr>

        <h2 id="version-initiale">Télécharger et installer la version initiale d'OpenFisca pour Windows</h2>

        <div class="panel panel-warning">
            <div class="panel-heading">
                <h2 class="panel-title">Avertissement</h2>
            </div>
            <div class="panel-body">
                <p>
                    La version initiale d'OpenFisca est désormais <strong>obsolète</strong>, n'est plus maintenue et son modèle socio-fiscal n'a pas été actualisé pour la législation à partir de 2013.
                </p>
                <p>
                    Cette version dispose toutefois de fonctionnalités non encore présentes dans la nouvelle version web, en particulier pour la gestion des données d'enquêtes. Ce qui peut justifier son utilisation dans certains cas à des fins de démonstration.
                </p>
            </div>
        </div>

        <p>
            Avant de commencer à utiliser OpenFisca, lire l’avertissement. Ensuite, cliquer sur le lien télécharger et enregistrer le fichier sur votre ordinateur. Dé-zipper le dossier, l’ouvrir et double-cliquer sur “OpenFisca.exe”. C’est tout, aucune installation préalable n’est nécessaire. Vous devrez peut être disposer de droits d’administrateur pour exécuter le programme.
        </p>
        <p>
            Pour un tutoriel rapide, regarder la vidéo.
        </p>
        <h3>Configuration recommandée</h3>
        Windows XP/Vista/7 avec 3 Go de RAM

        <h2>Pour les systèmes GNU/Linux</h2>
        <p>
            Télécharger le code source sur GitHub et exécuter OpenFisca.pyw. Vous aurez peut-être à rajouter le répertoire src dans votre PYTHONPATH et à installer les packages PyQt, Matplotlib, Numpy. OpenFisca a été développé et testé avec Python 2.7.
        </p>
    </div>
    <div class="col-md-3 hidden-print sidebar affix-top bs-docs-sidebar" id="sommaire" role="complementary">
        <ul class="nav sidenav" data-offset-top="60" data-spy="affix">
            <li>
                <a href="#gnu-linux">Installation Debian GNU/Linux</a>
                <ul class="nav">
                    <li><a href="#noyau-gnu-linux">Noyau OpenFisca</a></li>
                    <li><a href="#install-gnu-linux">API Web OpenFisca</a></li>
                    <li><a href="#install-ui-gnu-linux">Interface Utilisateur</a></li>
                </ul>
            </li>
            <li>
                <li>
                <a href="#windows">Installation Windows</a>
                <ul class="nav">
                    <li><a href="#noyau-windows">Noyau OpenFisca</a></li>
                    <li><a href="#install-windows">API Web OpenFisca</a></li>
                    <li><a href="#install-ui-windows">Interface Utilisateur</a></li>
                </ul>
            </li>

            <li>
                <li>
                <a href="#version-initiale">Version initiale</a>
            </li>


            <li><a class="back-to-top" href="#top">Back to top</a></li>
            </li>
        </ul>
    </div>
</div>
</%def>
