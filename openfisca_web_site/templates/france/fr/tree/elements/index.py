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


import textwrap

from openfisca_web_site import conf, model, urls


class Node(model.Folder):
    def iter_items(self):
        ctx = self.ctx
        yield dict(
            carousel_rank = 5,
            description = textwrap.dedent(u"""\
                Infographie représentant les constituants du revenu disponible sous forme de rayons de soleil
                """).strip(),
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = conf['urls.ui'],
            tags = [u'visualisation'],
            title = u"Visualisation en rayons du revenu disponible",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-sunburst.png'),
            updated = u'2014-05-28T16:00:00',
            )
#        yield dict(
#            description = u"""TODO""",
#            owner = u"TODO",
#            # TODO: source_url = u'https://github.com/TODO/TODO',
#            tags = [u'projet'],
#            title = u"TaxIPP Life (aka Til ou Tilof)",
#            updated = u'2014-05-02T07:00:00',
#            )
        yield dict(
            description = textwrap.dedent(u"""\
                Un convertisseur des fichiers au format SAS7BDAT en fichiers au format HDF5, importables dans OpenFisca
                en utilisant la bibliothèque Pandas
                """).strip(),
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/sas7bdat',
            tags = [u'projet'],
            title = u"sas7bdat",
            updated = u'2014-05-09T19:00:00',
            )
        yield dict(
            country = ['tunisia'],
            description = {
                "en": u"""The tunisian version of OpenFisca, without web nor user interface""",
                "fr": u"""La version tunisienne d'OpenFisca, sans web et sans interface utilisateur""",
                },
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-tunisia',
            tags = [u'projet'],
            title = u"OpenFisca-Tunisia",
            updated = u'2014-05-02T06:00:00',
            )
        yield dict(
            country = ['france'],
            description = {
                "en": u"""The french version of OpenFisca, without web nor user interface""",
                "fr": u"""La version française d'OpenFisca, sans web et sans interface utilisateur""",
                },
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-france',
            tags = [u'projet'],
            title = u"OpenFisca-France",
            updated = u'2014-05-02T06:00:00',
            )
        yield dict(
            country = ['france'],
            description = textwrap.dedent(u"""\
                Scripts extrayant les paramètres de la législation saisis par l'IPP dans des fichiers tableurs, et les
                les convertissant au format d'entrée de différents micro-simulateurs
                """).strip(),
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/legislation-ipp-to-code',
            tags = [u'projet'],
            title = u"Legislation-IPP-to-code",
            updated = u'2014-05-02T05:00:00',
            )
        yield dict(
            description = u"""Le site web www.openfisca.fr""",
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-web-site',
            tags = [u'projet'],
            title = u"OpenFisca-Web-Site",
            updated = u'2014-05-02T04:00:00',
            )
        yield dict(
            description = u"""L'interface web d'OpenFisca, utilisant uniquement OpenFisca-Web-API pour fonctionner""",
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-web-ui',
            tags = [u'projet'],
            title = u"OpenFisca-Web-UI",
            updated = u'2014-05-02T03:00:00',
            )
        yield dict(
            description = u"""L'API web d'OpenFisca, sans notion de pays et sans interface utilisateur""",
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-web-api',
            tags = [u'projet'],
            title = u"OpenFisca-Web-API",
            updated = u'2014-05-02T02:00:00',
            )
        yield dict(
            description = u"""La version française d'OpenFisca, sans web et sans interface utilisateur""",
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-france',
            tags = [u'projet'],
            title = u"OpenFisca-France",
            updated = u'2014-05-02T01:00:00',
            )
        yield dict(
            description = u"""Le moteur nu d'OpenFisca, sans notion de pays, sans web et sans interface utilisateur""",
            owner = u"OpenFisca Team",
            source_url = u'https://github.com/openfisca/openfisca-core',
            tags = [u'projet'],
            title = u"OpenFisca-Core",
            updated = u'2014-05-02T00:00:00',
            )
        yield dict(
            description = u"""Outil de visualisation des formules socio-fiscales intervenant dans le calcul d'un cas type, des valeurs de leurs paramètres et de leur résultat""",  # noqa
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../exemple-trace'),
            tags = [u'exemple', u'outil'],
            title = u"Outil trace",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-trace.png'),
            updated = u'2014-04-27T11:00:00',
            )
        yield dict(
            description = u"""Diagramme en cascade ("waterfall chart") de décomposition du revenu disponible d'un salarié célibataire sans enfant""",  # noqa
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../exemples/waterfall'),
            tags = [u'exemple'],
            title = u"Diagramme en cascade",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-waterfall.png'),
            updated = u'2014-04-21T07:00:00',
            )
        yield dict(
            country = [u'france'],
            description = u"""Script de comparaison entre les simulations OpenFisca et celles des impôts""",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = u'https://github.com/openfisca/openfisca-france/blob/master/openfisca_france/scripts/compare_openfisca_impots.py',  # noqa
            tags = [u'outil'],
            title = u"Comparateur impôts",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-comparateur-impots.png'),
            updated = u'2014-04-01T18:00:00',
            )
        yield dict(
            description = u"Graphe dynamique des dépendances entre les formules socio-fiscales d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../graphe-formules'),
            tags = [u'exemple'],
            title = u"Interdépendance des formules d'OpenFisca",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-graphe-formules.png'),
            updated = u'2014-03-28T09:00:00',
            )
        yield dict(
            featured = 5,
            description = u"Navigation dans les variables, les formules et la législation socio-fiscale d'OpenFisca",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = urls.get_full_url(ctx, self.url_path, '../variables'),
            tags = [u'outil'],
            title = u"Formules socio-fiscales",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-variable-revdisp.png'),
            updated = u'2014-03-28T08:00:00',
            )
        yield dict(
            country = [u'france'],
            carousel_rank = 6,
            description = u"Évolution du taux effectif d'imposition en fonction du salaire et du capital",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-regards-citoyens.jpeg'),
            owner = u"Regards citoyens",
            source_url = u'http://nbviewer.ipython.org/urls/raw.githubusercontent.com/regardscitoyens/openfisca-web-notebook/master/calcul_taux_effectif.ipynb',  # noqa
            tags = [u'utilisation'],
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
            title = u"Décomposition en tableau",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-tableau.png'),
            updated = u'2014-03-21T07:00:00',
            )
        yield dict(
            country = [u'france'],
            carousel_rank = 2,
            description = u"Simulez tous vos droits en ligne !",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"SGMAP",
            source_url = u'http://mes-aides.gouv.fr/',
            tags = [u'utilisation'],
            title = u"mes-aides.gouv.fr",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-mes-aides-gouv-fr.png'),
            updated = u'2014-10-01T11:01:00',
            )
        yield dict(
            country = [u'france'],
            carousel_rank = 3,
            description = u"Proposition de réforme du statut du quotient conjugal",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-openfisca.png'),
            owner = u"Équipe hackathon",
            source_url = urls.get_full_url(ctx, self.url_path, 'hackathon-2014-03-14/quotient-conjugal/'),
            tags = [u'utilisation'],
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
            tags = [u'utilisation'],
            title = u"Taux d'imposition du capital et du travail",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-taux-imposition-capital-travail.png'),
            updated = u'2014-03-24T19:17:00',
            )
        yield dict(
            carousel_rank = 1,
            description = u"Interface utilisateur de simulation d'une situation socio-fiscale",
            logo_url = urls.get_url(ctx, self.url_path, 'images', 'logo-etalab.png'),
            owner = u"Etalab",
            source_url = conf['urls.ui'],
            tags = [u'outil'],
            title = u"Simulateur en ligne",
            thumbnail_url = urls.get_url(ctx, self.url_path, 'images', 'vignette-ui.png'),
            updated = u'2014-03-01T07:26:00',
            )
