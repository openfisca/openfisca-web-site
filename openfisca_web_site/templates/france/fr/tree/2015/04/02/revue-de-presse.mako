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
Revue de presse
</%def>


<%def name="page_content()" filter="trim">
  <p class="text-justify">
    Le projet OpenFisca a fait l'objet ces trois derniers mois de trois articles de presse.
  </p>
  <p class="text-justify">
    En février, Regards Sur Le Numérique a publié
    <a href="http://www.rslnmag.fr/post/2015/02/02/OpenFisca-le-gouvernement-prepare-son-simulateur-de-reformes.aspx">
      OpenFisca : le gouvernement prépare son "simulateur de réformes"
    </a>.
  </p>
  <p class="text-justify">
    En mars, le blog « Binaire » du Monde a publié
    <a href="http://binaire.blog.lemonde.fr/2015/03/19/dessine-moi-les-impots/">
      Dessine moi les impôts !
    </a>.
  </p>
  <p class="text-justify">
    En avril, le Next Impact a publié
    <a href="http://www.nextinpact.com/news/93605-comment-l-etat-s-est-ouvert-a-l-open-source-avec-openfisca-et-mes-aides.htm">
      Comment l’État s’est ouvert à l’open source avec OpenFisca et Mes-aides
    </a>.
  </p>
  <p class="text-justify">
    Bonne lecture !
  </p>
  <div class="clearfix">
    <div class="pull-left">
      <blockquote class="twitter-tweet" data-partner="tweetdeck"><p>RT <a href="https://twitter.com/RSLNmag">@RSLNmag</a> <a href="https://twitter.com/OpenFisca">@OpenFisca</a> <a href="https://twitter.com/Etalab">@Etalab</a> <a href="https://twitter.com/IPPinfo">@IPPinfo</a> : le gouvernement prépare son &quot;simulateur de réformes&quot; <a href="http://t.co/AEr9HXeCL0">http://t.co/AEr9HXeCL0</a> <a href="http://t.co/crreaGksHz">pic.twitter.com/crreaGksHz</a></p>&mdash; Ariane Chastain (@ArianeChastain) <a href="https://twitter.com/ArianeChastain/status/566731111880216576">February 14, 2015</a></blockquote>
    </div>
    <div class="pull-left">
      <blockquote class="twitter-tweet" data-partner="tweetdeck"><p>Très chouette article sur <a href="https://twitter.com/OpenFisca">@OpenFisca</a> dans <a href="https://twitter.com/lemondefr">@lemondefr</a> ou comment le code fiscal devient du code informatique... <a href="http://t.co/kU1bzdLaai">http://t.co/kU1bzdLaai</a></p>&mdash; Christian Quest (@cq94) <a href="https://twitter.com/cq94/status/578503399869685760">March 19, 2015</a></blockquote>
    </div>
    <div class="pull-left">
      <blockquote class="twitter-tweet" lang="en"><p>Comment l’État s’est ouvert à l’open source avec <a href="https://twitter.com/OpenFisca">@OpenFisca</a> et <a href="https://twitter.com/MesAides">@MesAides</a> <a href="http://t.co/5u0nQnkZff">http://t.co/5u0nQnkZff</a> avec du <a href="https://twitter.com/fcouchet">@fcouchet</a> et du lcseguin inside :)</p>&mdash; Xavier Berne (@Xberne) <a href="https://twitter.com/Xberne/status/583550506519425024">April 2, 2015</a></blockquote>
    </div>
  </div>
</%def>


<%def name="scripts()" filter="trim">
    <%parent:scripts/>
    <script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
</%def>
