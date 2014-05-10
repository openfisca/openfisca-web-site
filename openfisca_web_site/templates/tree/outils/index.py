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
    def iter_tools(self, ctx):
        yield dict(
            description = u"""Outil web de visualisation des formules socio-fiscales intervenant dans le calcul d'un cas type, des valeurs de leurs paramètres et de leur résultat""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../exemple-trace'),
            owner = u"Etalab",
            title = u"Débogueur en ligne",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-trace.png'),
            updated = u'2014-04-27T11:00:00',
            )
        yield dict(
            description = u"""Script de comparaison entre les simulations OpenFisca et celles des impôts""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = u'https://github.com/openfisca/openfisca-france/blob/master/openfisca_france/scripts/compare_openfisca_impots.py',
            owner = u"Etalab",
            title = u"Comparateur impôts",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-comparateur-impots.png'),
            updated = u'2014-04-01T18:00:00',
            )
        yield dict(
            featured = 5,
            description = u"Navigation dans les variables, les formules et la législation socio-fiscale d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../variables/revdisp'),
            owner = u"Etalab",
            title = u"Formules socio-fiscales",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-variable-revdisp.png'),
            updated = u'2014-03-28T07:26:00',
            )
