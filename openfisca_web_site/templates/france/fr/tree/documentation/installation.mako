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
Installer OpenFisca
</%def>


<%def name="installing_openfisca_core()" filter="trim">
        <h3 id="installing-openfisca-core">Installer le Core</h3>

        <p>
            Cloner le dépôt Git OpenFisca-Core sur votre machine et installer le paquet Python.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-core.git
cd openfisca-core
pip install --editable . --user
python setup.py compile_catalog\
</pre>

        <p>
            Après l'installation d'OpenFisca-Core, la prochaine étape est d'installer le système socio-fiscal d'un pays.
        </p>
</%def>


<%def name="installing_openfisca_france()" filter="trim">
        <h3 id="installing-openfisca-france">Installer le Système Socio-Fiscal</h3>

        <p>
            Dans le cadre de cette documentation, nous allons installer le
            <a href="https://github.com/openfisca/openfisca-france" rel="external" target="_blank">
                système socio-fiscal français
            </a>
            mais vous pouvez aussi installer le
            <a href="https://github.com/openfisca/openfisca-tunisia" rel="external" target="_blank">tunisien</a>.
        </p>

        <p>
            Cloner le dépôt Git OpenFisca-France sur votre machine et installer le paquet Python.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-france.git
cd openfisca-france
pip install --editable . --user
python setup.py compile_catalog\
</pre>

        <p>
            Après l'installation d'OpenFisca-France, vous pouvez commencer à développer avec OpenFisca !
            Veuillez consulter la <a href="${urls.get_url(ctx, 'developing')}">documentation de développement</a>
            pour commencer.
        </p>
</%def>


<%def name="installing_prerequisites()" filter="trim">
        <h3 id="installing-prerequisites">Installer les pré-requis</h3>

        <p>
            Certains logiciels sont prérequis pour développer avec OpenFisca :
            le langage de programmation <a href="http://www.python.org/" rel="external" target="_blank">Python</a>,
            l'outil de gestion du code source nommé
            <a href="http://www.git-scm.com/" rel="external" target="_blank">Git</a>,
            ainsi que des paquets Python pré-compilés de calcul scientifique.
        </p>

        <p>
            Chaque logiciel s'installe de façon différente en fonction du système d'exploitation cible.
            Cliquer sur le "panel" ci-dessous correspondant à votre système d'exploitation.
        </p>

        <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="headingDebian">
                    <h4 class="panel-title">
                        <a class="collapsed" data-toggle="collapse" data-parent="#accordion" href="#collapseDebian" \
aria-expanded="true" aria-controls="collapseDebian">
                            Debian GNU/Linux (ou Ubuntu)
                        </a>
                    </h4>
                </div>
                <div id="collapseDebian" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingDebian">
                    <div class="panel-body">
                        <pre>\
su -
[tapez votre mot de passe root]
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
                        <p>
                                Si vous utilisez <a href="http://brew.sh"><code>brew</code></a>,
                                exécutez <code>brew install python</code> dans un terminal.
                        </p>
                        <p>
                                Sinon, exécutez <code>sudo easy_install pip</code> et
                                <a href="http://git-scm.com/download/mac">installez Git</a>.
                        </p>
                        
                        <p>Ensuite, exécutez la commande <code>pip install --upgrade setuptools</code>.</p>
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
                            Télécharger les paquets Python pré-compilé ici, correspondant à votre version de Python
                            (vérifiez avec <samp>python --version</samp>) et à l'architecture de votre microprocesseur
                            (certainement amd64):
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

        <p>À partir de maintenant vous devriez pouvoir ouvrir une fenêtre de terminal et taper des commandes.</p>

        <p>
          Créez un répertoire nommé <samp>openfisca</samp> qui contiendra les clones des différents dépôts Git.
          Ici nous choisissons de le créer directement dans votre répertoire utilisateur
          (atteignable avec la commande <samp>cd</samp> sans argument) mais vous pouvez choisir n'importe quel autre
          emplacement.
        </p>

        <pre>\
cd
mkdir openfisca
cd openfisca\
</pre>
</%def>



<%def name="installing_openfisca_web_api()" filter="trim">
        <h3 id="installing-openfisca-web-api">Installer l'API Web</h3>

        <div class="alert alert-info">
            <strong>Note :</strong> l'API est hébergée en ligne à l'adresse <samp>http://api.openfisca.fr/</samp>
            (<a href="${urls.get_url(ctx, 'api')}">documentation de l'API</a>). Vous n'avez pas besoin de l'installer
            pour l'utiliser sauf si vous souhaitez travailler sur son code, ou héberger une instance de l'API
            sur votre serveur.
        </div>

        <p>
            Cloner le dépôt Git OpenFisca-Web-API sur votre machine et installer le paquet Python.
        </p>

        <pre>\
cd ~/openfisca
git clone https://github.com/openfisca/openfisca-web-api.git
cd openfisca-web-api
pip install --editable .[dev] --user
python setup.py compile_catalog\
</pre>

        <p>Démarrer le serveur :</p>

        <pre>paster serve --reload development-france.ini</pre>

        <p>Pour arrêter le serveur, tapez <kbd>Ctrl-C</kbd> comme pour n'importe quelle autre commande.</p>

        <p>
          Pour tester, ouvrez l'URL suivante dans votre navigateur web :
          <a href="http://localhost:2000/" rel="external" target="_blank">http://localhost:2000/</a>
          (2000 est le numéro de port défini dans le fichier de configuration <samp>development-france.ini</samp>).
          Vous devriez voir un objet JSON expliquant que le chemin n'est pas trouvé, comme ceci:
        </p>

        <pre>{"apiVersion": "1.0", "error": {"message": "Path not found: /", "code": 404}}</pre>

        <div class="alert alert-info">
            <strong>Note :</strong> l'erreur est normale, elle dit simplement que le chemin de l'URL <samp>/</samp>
            ne correspond à aucun point d'entrée.
        </div>

        <p>
          Veuillez consulter la <a href="${urls.get_url(ctx, 'api')}">documentation de l'API</a>
          pour savoir comment l'utiliser, mais remplacez toutes les occurences du domaine
          <samp>api.openfisca.fr</samp> par <samp>localhost:2000</samp>.
        </p>
</%def>


<%def name="installing_openfisca_web_site()" filter="trim">
        <h3 id="installing-openfisca-web-site">Installer le Site Web</h3>

        <div class="alert alert-info">
            <strong>Note :</strong> le site web est hébergé en ligne à l'adresse
            <a href="${urls.get_full_url(ctx)}" rel="external" target="_blank">${urls.get_full_url(ctx)}</a>
            (vous êtes en train de le lire !).
            Vous ne devriez pas avoir besoin de l'installer, sauf si vous souhaitez travailler sur son code,
            ou héberger une instance du site web sur votre serveur, ce qui est plus qu'improbable.
        </div>

        <p>
            Le site web est une application web autonome. Veuillez consulter sa documentation pour l'installer.
            <a href="https://github.com/openfisca/openfisca-web-site" rel="external" target="_blank">
              Documentation d'OpenFisca-Web-Site
            </a>
        </p>
</%def>


<%def name="installing_openfisca_web_ui()" filter="trim">
        <h3 id="installing-openfisca-web-ui">Installer l'Interface Utilisateur</h3>

        <div class="alert alert-info">
            <strong>Note :</strong> l'interface utiliateur est hébergée en ligne à l'adresse
            <a href="http://ui.openfisca.fr/" rel="external" target="_blank">http://ui.openfisca.fr/</a>.
            Vous n'avez pas besoin de l'installer pour l'utiliser, sauf si vous souhaitez travailler sur son code,
            ou héberger une instance de l'interface utilisateur sur votre serveur.
        </div>

        <p>
            L'interface utilistateur est une application web autonome.
            Veuillez consulter sa documentation pour l'installer.
            <a href="https://github.com/openfisca/openfisca-web-ui" rel="external" target="_blank">
              Documentation d'OpenFisca-Web-UI
            </a>
        </p>
</%def>


<%def name="nav_content()" filter="trim">
            <li><a href="#installing-prerequisites">Prérequis</a></li>
            <li><a href="#installing-openfisca-core">Core</a></li>
            <li><a href="#installing-openfisca-france">Système Socio-Fiscal</a></li>
            <li><a href="#installing-openfisca-web-api">API Web</a></li>
            <li><a href="#installing-openfisca-web-ui">Interface Utilisateur</a></li>
            <li><a href="#installing-openfisca-web-site">Site Web</a></li>
</%def>


<%def name="page_content()" filter="trim">
    <div role="main">
        <div class="alert alert-info">
            <strong>Note :</strong> cette procédure d'installation est destinée aux développeurs qui veulent installer
            et exécuter OpenFisca sur leur ordinateur, et modifier le code source.
            Les systèmes d'exploitation ciblés sont, entre autres, les distributions GNU/Linux, Mac OS X et
            Microsoft Windows.
        </div>
        <%self:installing_prerequisites/>
        <%self:installing_openfisca_core/>
        <%self:installing_openfisca_france/>
        <%self:installing_openfisca_web_api/>
        <%self:installing_openfisca_web_ui/>
        <%self:installing_openfisca_web_site/>
    </div>
</%def>
