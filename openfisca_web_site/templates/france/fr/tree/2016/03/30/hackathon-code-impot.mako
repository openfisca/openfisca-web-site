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
1-2 avril : Hackathon #CodeImpot
</%def>


<%def name="page_content()" filter="trim">
  <p>
    <a href="https://twitter.com/hashtag/codeimpot">#CodeImpot</a> :
    un hackathon autour de l’ouverture du code source du calculateur impôts,
    les 1er et 2 avril 2016 à la
    <a href="https://twitter.com/MozillaParis">fondation Mozilla</a>
    (<a href="http://www.openstreetmap.org/node/2883451098">16 bis Boulevard Montmartre, 75009 Paris</a>).
  </p>
  <img src="/elements/images/logo-hackathon-code-impots-806x393.png" alt="logo">
  <p>
    Pour la première fois en France, une administration va au-delà de l’ouverture des données publiques et met à disposition le code source d’un de ses calculateurs. La Direction générale des finances publiques (DGFiP) ouvre ainsi à tous le code source de son calculateur impôts.
  </p>
  <p>
    Un <a href="https://mensuel.framapad.org/p/OpenImpots">Framapad</a> est ouvert à la contribution de tous
    pour recenser en amont de l’événement les idées des participants.
  </p>
  <p>
    Pour le projet OpenFisca, qui est chargé du support technique de ce code source, c'est l'occasion
    de le comparer avec le moteur d'OpenFisca et de tirer le meilleur parti des deux.
    En s’engageant dans le mouvement d’ouverture des codes sources des logiciels, la DGFiP ouvre la voie à la transparence des calculs et algorithmes qu’ils produisent. Cette démarche inédite pourrait faire école dans d’autres domaines, comme le calcul des droits à la retraite ou bien l’affectation des élèves dans l’enseignement supérieur.
  </p>
  <p>
    Voir aussi les articles publiés sur le
    <a href="https://www.etalab.gouv.fr/codeimpot-un-hackathon-autour-de-louverture-du-code-source-du-calculateur-impots">blog d'Etalab</a>
    et sur <a href="http://www.modernisation.gouv.fr/ladministration-change-avec-le-numerique/par-louverture-des-donnees-dans-les-administrations/openfisca-moteur-micro-simulation-fiscale-sociale">modernisation.gouv.fr</a>.
  </p>
</%def>
