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
    def iter_visualizations(self, ctx):
        yield dict(
            description = u"""Outil web de visualisation des formules socio-fiscales intervenant dans le calcul d'un cas type, des valeurs de leurs paramètres et de leur résultat""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../exemple-trace'),
            owner = u"Etalab",
            title = u"Débogueur",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-trace.png'),
            updated = u'2014-04-27T11:00:00',
            )
        yield dict(
            description = u"""Diagramme en cascade ("waterfall chart") de décomposition du revenu disponible d'un salarié célibataire sans enfant""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../exemple-waterfall'),
            owner = u"Etalab",
            title = u"Diagramme en cascade",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-waterfall.png'),
            updated = u'2014-04-21T07:00:00',
            )
        yield dict(
            description = u"Les aides que l'État peut apporter, en fonction de la situation des personnes",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            source_url = u'http://openfisca-dss.herokuapp.com/',
            owner = u"Équipe hackathon",
            title = u"Dossier social simplifié",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-dossier-social-simplifie.png'),
            updated = u'2014-03-14T19:19:00',
            )
        yield dict(
            description = u"Proposition de réforme du statut du quotient conjugal",
            featured = 3,
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            source_url = urls.get_full_url(ctx, self.url_path, 'hackathon-2014-03-14/quotient-conjugal/'),
            owner = u"Équipe hackathon",
            title = u"Réforme du quotient conjugal",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-quotient-conjugal.png'),
            updated = u'2014-03-24T19:19:00',
            )
        yield dict(
            description = u"Évolution du taux effectif d'imposition en fonction du salaire et du capital",
            featured = 2,
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-regards-citoyens.jpeg'),
            source_url = u'http://nbviewer.ipython.org/urls/raw.githubusercontent.com/regardscitoyens/openfisca-web-notebook/master/calcul_taux_effectif.ipynb',
            owner = u"Regards citoyens",
            title = u"Taux effectif d'imposition",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-effectif.png'),
            updated = u'2014-03-25T09:13:00',
            )
        yield dict(
            description = u"Différence des taux d'imposition en fonction des revenus du capital et du travail",
            featured = 4,
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            source_url = urls.get_full_url(ctx, self.url_path, 'hackathon-2014-03-14/taux-imposition-capital-travail.pdf'),
            owner = u"Équipe hackathon",
            title = u"Taux d'imposition du capital et du travail",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-imposition-capital-travail.png'),
            updated = u'2014-03-24T19:19:00',
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
            featured = 5,
            description = u"Navigation dans les variables, les formules et la législation socio-fiscale d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = urls.get_full_url(ctx, self.url_path, '../variables/revdisp'),
            owner = u"Etalab",
            title = u"Formules socio-fiscales",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-variable-revdisp.png'),
            updated = u'2014-03-28T07:26:00',
            )
        yield dict(
            featured = 1,
            description = u"Interface utilisateur de simulation d'une situation socio-fiscale",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            source_url = conf['ui.url'],
            owner = u"Etalab",
            title = u"Simulateur en ligne",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-ui.png'),
            updated = u'2014-03-01T07:26:00',
            )
