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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
OpenFisca au hackathon fiscalité à Dakar
</%def>


<%def name="page_content()" filter="trim">
<p>
    Les 3 et 4 novembre derniers s’est tenu à Dakar un hackathon dont le thème était « Innovation et Collaboration pour le système des impôts sénégalais ».
</p>
<p>
    L’événement était organisé par le Fonds Monétaire International et le Ministère de l’Économie, des Finances et du Plan du Sénégal, avec l’appui de MakeSense. Était notamment présente la Direction Générale des Impôts et des Domaines du Sénégal (DGID).
</p>
<p>
    Christophe Benz, l’un des développeurs du projet OpenFisca travaillant à Etalab, y a participé, ainsi qu’Adrien Pacifico, doctorant résident de l’école d’économie d’Aix-Marseille.
</p>
<p>
    <a class="btn btn-primary" href="https://www.etalab.gouv.fr/en/openfisca-au-hackathon-sur-la-fiscalite-de-dakar">
    Lire l'article complet
    </a>
</p>
</%def>
