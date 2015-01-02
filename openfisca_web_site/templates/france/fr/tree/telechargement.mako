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
Téléchargement
</%def>


<%def name="page_content()" filter="trim">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <h2 class="panel-title">Avertissement</h2>
            </div>
            <div class="panel-body">
                OpenFiscabeta calcule le montant de l'impôt sur le revenu et des prestations, pour l'année indiquée, à partir des informations que vous avez saisies. Ces montants sont donnés à titre indicatif et pourront être différents quand ils seront calculés par l'administration ou la Caf au moment de l'étude de votre dossier. Les résultats fournis ne sauraient engager l'administration ou votre Caf sur le montant définitif de l'impôt à acquitter ou des prestations versées. En effet, votre situation familiale et/ou vos ressources ou celles de l'un des membres de votre famille peuvent changer ou ne pas avoir été prises en compte lors de la simulation et certaines hypothèses simplificatrices ont été effectuées.
            </div>
        </div>

        <h2>Procédure</h2>
        <ul>
            <li>Télécharger la version qui correspond à votre système d'exploitation (windows 64 bits ou 32 bits).</li>
            <li>Dézipper le zip (clic droit sur le fichier zippé, puis « extraire tout ») dans le dossier de son choix. Le fichier dézippé fait 171 Mo et prend par défaut le nom du fichier zippé (on pourra le renommer).</li>
            <li>Un message d'erreur apparaît (« OpenFisca n'a pas pu ouvrir les données d'enquête… »). Passer outre et cliquer sur OK.</li>
            <li>Félicitations, vous pouvez désormais utilisez le logiciel !</li>
        </ul>

        <h2>Téléchargement</h2>
        <p><a href="https://github.com/openfisca/openfisca/downloads">Télécharger le logiciel pour windows.</a></p>
        <p><a href="https://github.com/openfisca/openfisca">Voir le code source sous Github</a></p>
</%def>
