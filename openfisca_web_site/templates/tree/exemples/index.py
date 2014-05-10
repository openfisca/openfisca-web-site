# -*- coding: utf-8 -*-


# OpenFisca -- A versatile microsimulation software
# By: OpenFisca Team <contact@openfisca.fr>
#
# Copyright (C) 2011, 2012, 2013, 2014 OpenFisca Team
# https://github.com/openfisca
#
# This file is part of OpenFisca.
#
# OpenFisca is free software; you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# OpenFisca is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


from openfisca_web_site import conf, model, urls


class Node(model.Folder):
    def iter_examples(self, ctx):
        yield dict(
            description = u"""Tableau de décomposition du revenu disponible d'un salarié célibataire sans enfant""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../exemples/waterfall'),
            owner = u"Etalab",
            title = u"Diagramme en cascade",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-waterfall.png'),
            updated = u'2014-04-21T07:00:00',
            )
        yield dict(
            description = u"Graphe dynamique des dépendances entre les formules socio-fiscales d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../graphe-formules'),
            owner = u"Etalab",
            title = u"Interdépendance des formules d'OpenFisca",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-graphe-formules.png'),
            updated = u'2014-03-28T07:26:00',
            )
        yield dict(
            description = u"""Diagramme en cascade ("waterfall chart") de décomposition du revenu disponible d'un salarié célibataire sans enfant""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../exemples/tableau'),
            owner = u"Etalab",
            title = u"Décomposition en tableau",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-tableau.png'),
            updated = u'2014-03-21T07:00:00',
            )
