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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
Résultats du sprint sur le revenu de base <small>du 19 décembre 2014</small>
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    Le <a href="${urls.get_url(ctx, '2014', '12', '05', 'sprint-revenu-de-base')}">sprint du 19 décembre 2014</a>
    sur le revenu de base s'est déroulé avec succès. Voici les résultats.
  </p>
  <p class="text-justify">
    Le principal objectif de ce sprint était de s'assurer qu'OpenFisca est bien adapté au codage des réformes et de le
    tester en modélisant le revenu de base.
  </p>
  <p class="text-justify">
    Voici les différentes ressources issues de cette journée.
  </p>
  <p class="text-justify">
    Tout d'abord, les
    <a href="${urls.get_url(ctx, 'elements', 'sprint-2014-12-19', 'specifications-revenu-de-base.odt')}">
      spécifications revenu de base
    </a> qui ont servi de point de départ à certains groupes.
  </p>
  <p class="text-justify">
    Les participants ont travaillé dans des
    <a href="http://ipython.org/notebook.html" rel="external" target="_blank">IPython Notebook</a> :
  </p>
  <ul>
    <li>
      <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/blob/master/presentation-openfisca.ipynb" rel="external" target="_blank">
        IPython Notebook de présentation d'OpenFisca
      </a>
    </li>
    <li>
      <a href="http://nbviewer.ipython.org/github/openfisca/openfisca-web-notebook/tree/master/2014-12-19-sprint-revenu-de-base/" rel="external" target="_blank">
        IPython Notebooks de certains participants
      </a>
    </li>
  </ul>
  <p class="text-justify">
    En fin de journée nous avons extrait les travaux des différents groupes et nous en avons fait des dépôts de code
    source indépendants :
  </p>
  <ul>
    <li>
      <a href="https://github.com/openfisca/openfisca-france-reform-revenu-de-base-enfants" rel="external" target="_blank">
        Revenu de base enfants
      </a>
    </li>
    <li>
      <a href="https://github.com/JeanEricHyafil/openfisca-france-reform-revenu-de-base-cotisations" rel="external" target="_blank">
        Cotisations revenu de base
      </a>
    </li>
  </ul>
  <p class="text-justify">
    Ces réformes sont visualisables dans le <a href="http://ui-test.openfisca.fr/">démonstrateur</a> (version de test).
    De plus elles ont été ajoutées à la
    <a href="${urls.get_url(ctx, 'reforms')}">liste des réformes</a>
    sur le site d'OpenFisca.
  </p>
  <div class="clearfix">
    <div class="pull-left">
      <blockquote class="twitter-tweet" lang="en"><p>Merci aux participants de ce sprint et à <a href="https://twitter.com/MozillaParis">@MozillaParis</a> pour son accueil. A bientôt pour un <a href="https://twitter.com/hashtag/hackathon?src=hash">#hackathon</a> <a href="https://twitter.com/hashtag/reformes?src=hash">#reformes</a> ! <a href="http://t.co/EmoWDnGelI">pic.twitter.com/EmoWDnGelI</a></p>&mdash; OpenFisca (@OpenFisca) <a href="https://twitter.com/OpenFisca/status/546058400023732224">December 19, 2014</a></blockquote>
    </div>
    <div class="pull-left">
      <blockquote class="twitter-tweet" lang="en"><p>Le sprint <a href="https://twitter.com/OpenFisca">@OpenFisca</a> fait salle comble à la fondation <a href="https://twitter.com/MozillaParis">@MozillaParis</a> ! Au pg : reformes, <a href="https://twitter.com/hashtag/revenudebase?src=hash">#revenudebase</a>... <a href="http://t.co/XLLKHjlzh2">pic.twitter.com/XLLKHjlzh2</a></p>&mdash; OpenFisca (@OpenFisca) <a href="https://twitter.com/OpenFisca/status/545906845970599936">December 19, 2014</a></blockquote>
    </div>
  </div>
  <p class="text-justify">
    Merci encore à tous pour votre participation et à la prochaine !
  </p>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</%def>
