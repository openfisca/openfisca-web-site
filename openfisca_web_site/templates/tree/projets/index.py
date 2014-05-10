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


import textwrap

from openfisca_web_site import model


class Node(model.Folder):
    def iter_projects(self, ctx):
#        yield dict(
#            description = u"""TODO""",
#            # TODO: source_url = u'https://github.com/TODO/TODO',
#            owner = u"TODO",
#            title = u"TaxIPP Life (aka Til ou Tilof)",
#            updated = u'2014-05-02T07:00:00',
#            )
        yield dict(
            description = textwrap.dedent(u"""\
                Un convertisseur des fichiers au format SAS7BDAT en fichiers au format HDF5, importables dans OpenFisca
                en utilisant la bibliothèque Pandas
                """).strip(),
            source_url = u'https://github.com/openfisca/sas7bdat',
            owner = u"OpenFisca Team",
            title = u"sas7bdat",
            updated = u'2014-05-09T19:00:00',
            )
        yield dict(
            description = u"""La version tunisienne d'OpenFisca, sans web et sans interface utilisateur""",
            source_url = u'https://github.com/openfisca/openfisca-tunisia',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-Tunisia",
            updated = u'2014-05-02T06:00:00',
            )
        yield dict(
            description = textwrap.dedent(u"""\
                Scripts extrayant les paramètres de la législation saisis par l'IPP dans des fichiers tableurs, et les
                les convertissant au format d'entrée de différents micro-simulateurs
                """).strip(),
            source_url = u'https://github.com/openfisca/legislation-ipp-to-code',
            owner = u"OpenFisca Team",
            title = u"Legislation-IPP-to-code",
            updated = u'2014-05-02T05:00:00',
            )
        yield dict(
            description = u"""Le site web www.openfisca.fr""",
            source_url = u'https://github.com/openfisca/openfisca-web-site',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-Web-Site",
            updated = u'2014-05-02T04:00:00',
            )
        yield dict(
            description = u"""L'interface web d'OpenFisca, utilisant uniquement OpenFisca-Web-API pour fonctionner""",
            source_url = u'https://github.com/openfisca/openfisca-web-ui',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-Web-UI",
            updated = u'2014-05-02T03:00:00',
            )
        yield dict(
            description = u"""L'API web d'OpenFisca, sans notion de pays et sans interface utilisateur""",
            source_url = u'https://github.com/openfisca/openfisca-web-api',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-Web-API",
            updated = u'2014-05-02T02:00:00',
            )
        yield dict(
            description = u"""La version française d'OpenFisca, sans web et sans interface utilisateur""",
            source_url = u'https://github.com/openfisca/openfisca-france',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-France",
            updated = u'2014-05-02T01:00:00',
            )
        yield dict(
            description = u"""Le moteur nu d'OpenFisca, sans notion de pays, sans web et sans interface utilisateur""",
            source_url = u'https://github.com/openfisca/openfisca-core',
            owner = u"OpenFisca Team",
            title = u"OpenFisca-Core",
            updated = u'2014-05-02T00:00:00',
            )
