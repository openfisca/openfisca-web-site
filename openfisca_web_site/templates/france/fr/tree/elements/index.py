# -*- coding: utf-8 -*-


# OpenFisca -- A versatile microsimulation software
# By: OpenFisca Team <contact@openfisca.fr>
#
# Copyright (C) 2011, 2012, 2013, 2014, 2015 OpenFisca Team
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


import urlparse

from openfisca_web_site import conf, model, urls


class Node(model.Folder):
    def iter_items(self):
        ctx = self.ctx
        yield dict(
            featured = 5,
            description = u"Navigation dans les variables, les formules et la législation socio-fiscale d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = conf['urls.legislation'],
            tags = [u'tool'],
            title = ctx._(u'Legislation explorer'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-variable-revdisp.png'),
            updated = u'2014-03-28T08:00:00',
            )
        yield dict(
            description = u"""Outil de visualisation des formules socio-fiscales intervenant dans le calcul d'un cas type, des valeurs de leurs paramètres et de leur résultat""",  # noqa
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../tools/trace'),
            tags = [u'tool'],
            title = ctx._(u"Trace tool"),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-trace.png'),
            updated = u'2014-04-27T11:00:00',
            )
        yield dict(
            description = u"Graphe dynamique des dépendances entre les formules socio-fiscales d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../tools/variables-graph'),
            tags = [u'tool'],
            title = ctx._(u'Tax-benefit variables interdependence graph'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-variables-graph.png'),
            updated = u'2014-03-28T09:00:00',
            )
        yield dict(
            carousel_rank = 2,
            description = u"""\
Décrivez votre situation familiale, saisissez vos revenus et
votre patrimoine, et découvrez votre situation socio-fiscale, situez-vous par rapport aux autres foyers,
découvrez votre niveau de vie, etc.""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = conf['urls.ui'],
            tags = [u'tool'],
            title = ctx._(u'OpenFisca Demonstrator'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-ui.png'),
            updated = u'2014-03-01T07:26:00',
            )
        yield dict(
            description = u"""Diagramme en cascade ("waterfall chart") de décomposition du revenu disponible d'un salarié célibataire sans enfant""",  # noqa
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../exemples/waterfall'),
            tags = [u'exemple'],
            title = ctx._(u'Waterfall diagram'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-waterfall.png'),
            updated = u'2014-04-21T07:00:00',
            )
        yield dict(
            carousel_rank = 2,
            country = [u'france'],
            description = u"Simulez toutes vos aides en ligne !",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"SGMAP",
            source_url = u'http://mes-aides.gouv.fr/',
            tags = [u'community'],
            title = u"mes-aides.gouv.fr",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-mes-aides-gouv-fr.png'),
            updated = u'2014-10-01T11:01:00',
            )
        yield dict(
            carousel_rank = 2,
            country = [u'france'],
            description = u"Estimez le coût d'une embauche dans votre entreprise, et combien le salarié touchera.",  # noqa
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"SGMAP",
            source_url = u'http://embauche.sgmap.fr/',
            tags = [u'community'],
            title = u"Simulateur de coût d'embauche",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-simulateur-embauche.png'),
            updated = u'2015-11-05T18:01:00',
            )
        yield dict(
            carousel_rank = 6,
            country = [u'france'],
            description = u"Évolution du taux effectif d'imposition en fonction du salaire et du capital",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-regards-citoyens.jpeg'),
            owner = u"Regards citoyens",
            source_url = u'http://nbviewer.ipython.org/urls/raw.githubusercontent.com/regardscitoyens/openfisca-web-notebook/master/calcul_taux_effectif.ipynb',  # noqa
            tags = [u'community'],
            title = u"Taux effectif d'imposition",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-effectif.png'),
            updated = u'2014-03-25T09:13:00',
            )
        yield dict(
            description = u"""Tableau de décomposition du revenu disponible d'un salarié célibataire sans enfant""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../exemples/tableau'),
            tags = [u'exemple'],
            title = ctx._(u'Tabular decomposition'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-tableau.png'),
            updated = u'2014-03-21T07:00:00',
            )
        yield dict(
            country = [u'france'],
            carousel_rank = 3,
            description = u"Proposition de réforme du statut du quotient conjugal",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"Équipe hackathon",
            source_url = urls.get_full_url(ctx, self.url_path, 'hackathon-2014-03-14/quotient-conjugal/'),
            tags = [u'community'],
            title = u"Réforme du quotient conjugal",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-quotient-conjugal.png'),
            updated = u'2014-03-24T19:18:00',
            )
        yield dict(
            country = [u'france'],
            carousel_rank = 4,
            description = u"Différence des taux d'imposition en fonction des revenus du capital et du travail",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"Équipe hackathon",
            source_url = urls.get_full_url(
                ctx,
                self.url_path,
                'hackathon-2014-03-14/taux-imposition-capital-travail.pdf',
                ),
            tags = [u'community'],
            title = u"Taux d'imposition du capital et du travail",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-imposition-capital-travail.png'),
            updated = u'2014-03-24T19:17:00',
            )
        yield dict(
            country = [u'france'],
            description = u"""Script de comparaison entre les simulations OpenFisca et celles des impôts""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = u'https://github.com/openfisca/openfisca-france/blob/master/openfisca_france/scripts/calculateur_impots/compare_openfisca_impots.py',  # noqa
            tags = [u'tool'],
            title = ctx._(u'Taxes simulations comparator'),
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-comparateur-impots.png'),
            updated = u'2014-04-01T18:00:00',
            )
        yield dict(
            country = [u'france'],
            description = u"""Le revenu de base est un droit inaliénable, \
inconditionnel, cumulable avec d’autres revenus, distribué par une communauté politique à tous ses membres, \
de la naissance à la mort, sur base individuelle, sans contrôle des ressources ni exigence de contrepartie, \
dont le montant et le financement sont ajustés démocratiquement.""",
            owner = u"Équipe sprint revenu de base",
            source_url = u'https://github.com/openfisca/openfisca-france-extension-revenu-de-base',
            tags = [u'extension'],
            title = u'Revenu de base',
            updated = u'2015-11-02T18:30:00',
            )
        yield dict(
            country = [u'france'],
            # TODO description = u'',
            owner = u"Équipe OpenFisca",
            source_url = u'https://github.com/openfisca/openfisca-france/blob/master/openfisca_france/extensions/landais_piketty_saez.py',  # noqa
            tags = [u'extension'],
            title = u'Réforme Landais Piketty Saez',
            updated = u'2015-11-02T18:30:00',
            )
        # yield dict(
        #     description = u'Développez en Python dans le cloud d\'OpenFisca ! Totalement en ligne, avec comptes utilisateurs, sans installer de logiciels sur votre ordinateur.',  # noqa
        #     logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
        #     owner = u"Équipe OpenFisca",
        #     source_url = 'https://jupyter.openfisca.fr/',
        #     tags = [u'tool'],
        #     title = ctx._(u'Jupyter notebook with OpenFisca'),
        #     thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'logo-jupyter.svg'),
        #     updated = u'2016-02-26T18:00:00',
        #     )
        yield dict(
            carousel_rank = 1,
            country = [u'france'],
            owner = u"DGFiP / Etalab",
            source_url = urlparse.urljoin(conf['urls.forum'], '/t/acceder-au-code-source-de-la-calculette-impots/37'),
            tags = [u'calculette-impots'],
            title = u"Ouverture de la Calculette Impôts",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'cerfa-2042.png'),
            updated = u'2016-04-05T16:17:00',
            )
