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


<%inherit file="/page-avec-nav.mako"/>


<%def name="block_debian()" filter="trim">
    <h2 id="gnu-linux">Installation sous <strong>Debian GNU/Linux</strong></h2>

    <div class="alert alert-danger">
        <strong>Attention :</strong> cette installation est valable pour les versions testing et unstable de Debian.
    </div>

    <h3 id="noyau-gnu-linux">Installation du noyau d'OpenFisca</h3>

    <ul>
        <li>
            Afin de pouvoir lancer l'API, certain paquets sont nécessaires, pour les installer, lancer les commandes
            suivantes :
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
sudo apt-get install python-weberror</pre>
        </li>
    </ul>

    <h4 id="ensuite-gnu-linux">Oui, mais ensuite ?</h4>

    <ul>
        <li>
            Si vous voulez mettre vos fichiers dans "Documents", effectuez les commandes suivantes dans le terminal :
            <pre>cd Documents
mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :
            <pre>git clone https://github.com/etalab/biryani.git
git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git</pre>
        </li>
        <li>Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :
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
        <strong>Attention :</strong> pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les
        liens de simulation et de législation par vos liens locaux :
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
            Afin d'installer l'API web, effectuez les commandes dans l'ordre :
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            Afin d'installer l'API, effectuez les commandes dans l'ordre :
            <pre>cd openfisca-web-api
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-gnu-linux">Lancer le serveur</h4>

    <ul>
        <li>
            Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez
            dans le dossier <code>openfisca-web-api</code>) lancer la commande suivante :
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Attention :</strong> pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les
        liens de simulation et de législation par vos liens locaux :
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
        Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small>
    </h3>

    <ul>
        <li>
            Pour installer l'UI, il faut  aller dans son dossier openfisca et installer les paquets nécessaires :
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
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API et MongoDB dans des consoles différentes :
    </p>
    <ul>
        <li>Tout d'abord, dans un premier onglet, lancer l'API :
            <pre>cd Documents/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>Enusite, dans un deuxième onglet, lancer MongoDB (ici installé dans le dossier openfisca) :
            <pre>sudo service mongodb start</pre>
        </li>
        <li>Enfin, dans un troisième onglet, lancer le serveur de l'Interface utilisateur :
            <pre>cd Documents/openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini création des index dans la base de donnée
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-linux">Ouvrir l'interface</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-gnu-linux">Installation du site OpenFisca</h3>

    <ul>
        <li>
            Pour installer le site, il faut ouvrir un nouvel onglet (<kbd>ctrl + shift + T</kbd>), aller dans son
            dossier openfisca et installer les fichiers git :
            <pre>cd Documents/openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>
    <p class="alert alert-danger">
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API dans une console différente :
    </p>
    <ul>
        <li>
            Tout d'abord, dans un premier onglet, lancer l'API :
            <pre>cd Documents/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Ensuite, dans un deuxième onglet, lancer le serveur du site :
            <pre>cd Documents/openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-linux">Ouvrir le site</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="block_heroku()" filter="trim">
    <h2 id="heroku">Installation sur Heroku</h2>

    <ul>
        <li>
            Tout d'abord, s'inscrire sur <a href="https://www.heroku.com/" target="_blank">Heroku</a>
        </li>
        <li>
            Télécharcher et installer <a href="https://toolbelt.heroku.com/" target="_blank">Heroku Toolbelt</a>
        </li>
        <li>
            Une fois installé, vous aurez accès à la commande heroku de votre shell. Connectez-vous en utilisant
            l'adresse e-mail et le mot de passe que vous avez utilisés lors de la création de votre compte Heroku :
            <pre>heroku login</pre>
        </li>
        <li>
            Une fois installé, il faut se rendre dans son dossier "openfisca-web-site" et effectuer les commandes
            suivantes afin de lancer le serveur sur Heroku :
            <pre>heroku create --region eu --buildpack https://github.com/jdesboeufs/heroku-buildpack-openfisca
git push heroku master
heroku open</pre>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Attention :</strong> pour lancer vos tests sur Heroku, dans vos fichiers test, vous devez remplacer les
        liens de simulation et de législation par le lien de la page qui s'est ouvert quand vous avez fait
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
                La version initiale d'OpenFisca est désormais <strong>obsolète</strong>, n'est plus maintenue et son
                modèle socio-fiscal n'a pas été actualisé pour la législation à partir de 2013.
            </p>
            <p>
                Cette version dispose toutefois de fonctionnalités non encore présentes dans la nouvelle version web, en
                particulier pour la gestion des données d'enquêtes. Ce qui peut justifier son utilisation dans certains
                cas à des fins de démonstration.
            </p>
        </div>
    </div>

    <p>
        Avant de commencer à utiliser OpenFisca, lire l'avertissement. Ensuite, cliquer sur le lien télécharger et
        enregistrer le fichier sur votre ordinateur. Dé-zipper le dossier, l'ouvrir et double-cliquer sur
        <code>OpenFisca.exe</code>. C'est tout, aucune installation préalable n'est nécessaire. Vous devrez peut être
        disposer de droits d'administrateur pour exécuter le programme.
    </p>
    <p>
        Pour un tutoriel rapide, regarder la vidéo.
    </p>

    <h3>Configuration recommandée</h3>

    Windows XP/Vista/7 avec 3 Go de RAM

    <h2>Pour les systèmes GNU/Linux</h2>

    <p>
        Télécharger le code source sur GitHub et exécuter OpenFisca.pyw. Vous aurez peut-être à rajouter le répertoire
        <code>src</code> dans votre <code>PYTHONPATH</code> et à installer les packages PyQt, Matplotlib, Numpy.
    </p>
    <p>
        OpenFisca a été développé et testé avec Python 2.7.
    </p>
</%def>


<%def name="block_mac()" filter="trim">

    <h2 id="mac">Installation sous <strong>Mac OS</strong></h2>

    <h3 id="noyau-mac">Installation du noyau d'OpenFisca</h3>

    <ul>
        <li>
            Installer <a href="http://brew.sh/index_fr.html">Homebrew</a>
        </li>
        <li>
            Afin de pouvoir lancer l'API, certain paquets sont nécessaires, pour les installer, lancer les commandes
            suivantes :
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
sudo pip install weberror</pre>
        </li>
    </ul>

    <h4 id="ensuite-gnu-mac">Oui, mais ensuite ?</h4>

    <ul>
        <li>
            Si vous voulez mettre vos fichiers a la racine, effectuez les commandes suivantes dans le terminal :
            <pre>mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :
            <pre>git clone https://github.com/etalab/biryani.git
git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git</pre>
        </li>
        <li>
            Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :
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

    <h3 id="install-mac">Installation de l'API Web d'OpenFisca</h3>

    <ul>
        <li>
            Pour cloner les fichiers de l'api sur votre machine, effectuez la commande suivante :
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            Afin d'installer l'API, effectuez les commandes dans l'ordre :
            <pre>cd ../openfisca-web-api
python setup.py compile_catalog
sudo python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-mac">Lancer le serveur</h4>

    <ul>
        <li>
            Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez
            dans le dossier "openfisca-web-api") lancer la commande suivante :
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Attention :</strong> pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les
        liens de simulation et de législation par vos liens locaux :
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
        Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small>
    </h3>

    <ul>
        <li>
            Pour installer l'UI, il faut ouvrir un nouvel onglet (<kbd>ctrl + shift + T</kbd>), aller dans son dossier
            openfisca et installer les paquets essentiels :
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
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API et MongoDB dans des consoles différentes :
    </p>
    <ul>
        <li>
            Tout d'abord, dans un premier onglet, lancer l'API :
            <pre>cd /openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Enusite, dans un deuxième onglet, lancer MongoDB (ici installé dans le dossier openfisca) :
            <pre>mongod</pre>
        </li>
        <li>
            Enfin, dans un troisième onglet, lancer le serveur de l'Interface utilisateur :
            <pre>cd /openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini #création des index dans la base de donnée
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-mac">Ouvrir l'interface</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-mac">Installation du site OpenFisca</h3>

    <ul>
        <li>
            Pour installer le site, il faut ouvrir un nouvel onglet (<kbd>ctrl + shift + T</kbd>), aller dans son
                dossier openfisca et installer les fichiers git :
            <pre>cd /openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API dans une console différente :
    </p>
    <ul>
        <li>
            Tout d'abord, dans un premier onglet, lancer l'API :
            <pre>cd /openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Ensuite, dans un deuxième onglet, lancer le serveur du site :
            <pre>cd /openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-mac">Ouvrir le site</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="block_windows()" filter="trim">
    <h2 id="windows">Installation sous <strong>Windows</strong></h2>

    <h3 id="noyau-windows">Installation du noyau d'OpenFisca</h3>

    <ul>
        <li>
            Installer <a href="https://www.python.org/download/releases/2.7.6/">Python 2.7.6</a>
        </li>
        <li>
            Installer <a href="git-scm.com/download/win">Git</a>, ouvrir le .exe et choisissez tout par defaut sauf
            "adjusting yout PATH environment" et selectionnez "run Git from the Windows Command Prompt"
        </li>
        <li>
            Télécharger <a href="http://www.lfd.uci.edu/~gohlke/pythonlibs/#setuptools" target="_blank">"Setuptools"</a>
            dans leur version pour Python 2.7
        </li>
    </ul>

    <h4 id="ensuite-windows">Oui, mais ensuite ?</h4>

    <ul>
        <li>
            Tout d'abord, il faut ouvrir la commande Windows, le plus simple étant de faire la touche
            <kbd>Windows + R</kbd>, de taper <kbd>cmd</kbd> puis ok.
        </li>
        <li>
            Si vous voulez mettre vos fichiers sur le bureau, effectuez les commandes suivantes dans la
            <abbr title="windows command prompt">CMD</abbr> :
            <pre>cd Desktop
mkdir openfisca
cd openfisca</pre>
        </li>
        <li>
            Pour cloner les fichiers openfisca sur votre machine, effectuez les 3 commandes suivantes :
            <pre>git clone http://github.com/openfisca/openfisca-core.git
git clone http://github.com/openfisca/openfisca-france.git
git clone https://github.com/etalab/biryani.git</pre>
        </li>
        <li>
            Afin d'installer chaque partie d'openfisca, effectuez les commandes suivantes dans l'ordre :
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
            Pour cloner les fichiers de l'api sur votre machine, effectuez la commande suivante :
            <pre>git clone http://github.com/openfisca/openfisca-web-api.git</pre>
        </li>
        <li>
            Afin d'installer l'API, effectuez les commandes dans l'ordre :
            <pre>cd ../openfisca-web-api
python setup.py compile_catalog
python setup.py develop --no-deps</pre>
        </li>
    </ul>

    <h4 id="serveur-windows">Lancer le serveur</h4>

    <ul>
        <li>
            Une fois toutes ces étapes finis, il faut, toujours dans la même commande (normalement vous vous trouvez
            dans le dossier "openfisca-web-api") lancer la commande suivante :
            <pre>paster serve --reload development.ini</pre>
        </li>
        <li>
            Pour arreter le serveur, dans la commande faire <kbd>ctrl + C</kbd>
        </li>
    </ul>

    <div class="alert alert-danger">
        <strong>Attention :</strong> pour lancer vos tests localement, dans vos fichiers test, vous devez remplacer les
        liens de simulation et de législation par vos liens locaux :
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
        Installation de l'Interface Utilisateur <small>(non indispensable pour faire tourner l'API Web)</small>
    </h3>
    <ul>
        <li>
            Pour installer l'UI, il faut ouvrir une nouvelle commande (<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd> -&gt;
            OK) et aller dans son dossier openfisca :
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
            Télécharger ensuite <a href="http://nodejs.org/download/">nodejs</a> et executer le .exe
        </li>
        <li>
            Une fois l'installation terminée, il faut télécharger
            <a href="https://www.mongodb.org/downloads">MongoDB</a> et l'installer
        </li>
        <li>
            Vous aurez sûrement besoin de redémmarer votre machine afin de prendre certains paramètres en compte
        </li>
        <li>
            Installer bower :
            <pre>npm install -g bower</pre>
        </li>
        <li>
            Installer bower dans openfisca/openfisca-web-ui :
            <pre>cd Desktop/openfisca/openfisca-web-ui
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API et MongoDB dans des consoles différentes :
    </p>
    <ul>
        <li>
            Tout d'abord, dans une première console, lancer l'API :
            <pre>cd Desktop/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Enusite, dans une deuxième console, lancer MongoDB (ici installé dans le dossier openfisca) :
            <pre>cd Desktop/openfisca/mongodb/bin
mongod.exe</pre>
        </li>
        <li>
            Enfin, dans une troisième console, lancer le serveur de l'Interface utilisateur :
            <pre>cd Desktop/openfisca/openfisca-web-ui
./openfisca_web_ui/scripts/setup_app.py development.ini #création des index dans la base de donnée
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="interface-windows">Ouvrir l'interface</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2015</kbd>
        </li>
    </ul>

    <h3 id="install-site-windows">Installation du site OpenFisca</h3>

    <ul>
        <li>
            Pour installer le site, il faut ouvrir une nouvelle commande (<kbd>Windows + R</kbd> -&gt; <kbd>cmd</kbd>
            -&gt; OK), aller dans son dossier openfisca et installer les fichiers git :
            <pre>cd Desktop/openfisca
git clone https://github.com/openfisca/openfisca-web-site.git
cd openfisca-web-site
python setup.py compile_catalog
sudo python setup.py develop --no-deps
bower install</pre>
        </li>
    </ul>

    <p class="alert alert-danger">
        <strong>Attention :</strong> pour lancer le serveur de l'interface, vous devez lancer d'abord le serveur de
        l'API dans une console différente :
    </p>

    <ul>
        <li>
            Tout d'abord, dans une premiere console, lancer l'API :
            <pre>cd Desktop/openfisca/openfisca-web-api
paster serve --reload development.ini</pre>
        </li>
        <li>
            Ensuite, dans une deuxième console, lancer le serveur du site :
            <pre>cd Desktop/openfisca/openfisca-web-site
paster serve --reload development.ini</pre>
        </li>
    </ul>

    <h4 id="site-windows">Ouvrir le site</h4>

    <ul>
        <li>
            Pour ouvrir l'interface utilisateur, il vous suffit d'ouvrir votre navigateur internet et d'aller à
            l'adresse du lien suivant : <kbd>http://localhost:2016</kbd>
        </li>
    </ul>
</%def>


<%def name="h1_content()" filter="trim">
Installation d'OpenFisca
</%def>


<%def name="nav_content()" filter="trim">
            <li>
                <a href="#gnu-linux">Installation Debian GNU/Linux</a>
                <ul class="nav">
                    <li><a href="#noyau-gnu-linux">Noyau OpenFisca</a></li>
                    <li><a href="#install-gnu-linux">API Web OpenFisca</a></li>
                    <li><a href="#install-ui-gnu-linux">Interface Utilisateur</a></li>
                    <li><a href="#install-site-gnu-linux">Site Web OpenFisca</a></li>
                </ul>
            </li>
            <li>
                <a href="#heroku">Installation Heroku</a>
            </li>
            <li>
                <a href="#mac">Installation Mac OS</a>
                <ul class="nav">
                    <li><a href="#noyau-mac">Noyau OpenFisca</a></li>
                    <li><a href="#install-mac">API Web OpenFisca</a></li>
                    <li><a href="#install-ui-mac">Interface Utilisateur</a></li>
                    <li><a href="#install-site-mac">Site Web OpenFisca</a></li>
                </ul>
            </li>
            <li>
                <a href="#windows">Installation Windows</a>
                <ul class="nav">
                    <li><a href="#noyau-windows">Noyau OpenFisca</a></li>
                    <li><a href="#install-windows">API Web OpenFisca</a></li>
                    <li><a href="#install-ui-windows">Interface Utilisateur</a></li>
                    <li><a href="#install-site-windows">Site Web OpenFisca</a></li>
                </ul>
            </li>
            <li>
                <a href="#version-initiale">Installation version initiale</a>
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
