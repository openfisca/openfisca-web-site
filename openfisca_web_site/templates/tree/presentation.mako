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


<%inherit file="/page.mako"/>


<%def name="h1_content()" filter="trim">
${_(u"Presentation")}
</%def>


<%def name="page_content()" filter="trim">
        <h2>Qu’est-ce qu’OpenFisca</h2>
        <p>
            OpenFisca est un logiciel libre de simulation du système socio-fiscal français. Il permet de visualiser simplement un grand nombre de prestations sociales et d’impôts payés, par les ménages, et de simuler l’impact de réformes sur le budget des ménages. Il s’agit d’un outil à vocation pédagogique pour aider les citoyens à mieux comprendre le système socio-fiscal.
        </p>
        <p>
            À terme, OpenFisca intégrera l’ensemble du système socio-fiscal français et son évolution et permettra de calculer l’impact de réformes sur le budget de l’État.
        </p>

        <h2>Vidéo de présentation d'OpenFisca</h2>
        <object type="application/x-shockwave-flash" data="videos/player.swf" width="900" height="506">
            <param name="movie" value="videos/player.swf" />
            <param name="allowFullScreen" value="true" />
            <param name="FlashVars" value="flv=videos/video.flv&amp;width=900&amp;height=506" />
        </object>

        <h2>Comment contribuer à OpenFisca</h2>
        <p>
            OpenFisca est un projet en cours de développement sous licence GPLv3 ou supérieure. Le code source est librement accessible et modifiable. Certains pans de la législation ne sont pas encore intégrés. Étant donné l’ampleur de la tâche, notre ambition est de constituer une communauté de développeurs, d’économistes et de spécialistes de la fiscalité ou des prestations sociales pour maintenir et améliorer le programme.
        </p>
        <p>
            Nous invitons les utilisateurs à nous transmettre leur remarques, les imprécisions ou erreurs identifiées, ainsi que les éventuelles propositions d’amélioration. Si vous voulez participer plus activement à l’évolution du programme, vous pouvez télécharger le code source sur GitHub et/ou nous contacter.
        </p>

        <h2>Télécharger et installer OpenFisca pour Windows</h2>
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
</%def>
