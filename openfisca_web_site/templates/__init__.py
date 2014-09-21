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


"""Mako templates rendering"""


import email.header
import json
import os

import mako.lookup

from .. import conf


dir = None  # Templates directory, inited by function load_environment
js = lambda x: json.dumps(x, encoding = 'utf-8', ensure_ascii = False)
lookup_by_country_and_lang_couple = {}
relative_dirs_by_country_and_lang_couple = {
    ('france', 'en'): [os.path.join('france', 'en'), os.path.join('france', 'fr'), '.'],
    ('france', 'fr'): [os.path.join('france', 'fr'), '.'],
    ('tunisia', 'ar'): [os.path.join('tunisia', 'ar'), os.path.join('tunisia', 'fr'), os.path.join('france', 'fr'),
        '.'],
    ('tunisia', 'en'): [os.path.join('tunisia', 'en'), os.path.join('tunisia', 'fr'), os.path.join('france', 'fr'),
        '.'],
    ('tunisia', 'fr'): [os.path.join('tunisia', 'fr'), os.path.join('france', 'fr'), '.'],
    }


def get_existing_path(ctx, *paths):
    country = ctx.country
    lang = ctx.lang[0]
    country_and_lang_couple = (country, lang)
    for relative_dir in relative_dirs_by_country_and_lang_couple[country_and_lang_couple]:
        found_path = os.path.join(dir, relative_dir, *paths)
        if os.path.exists(found_path):
            return found_path
    return None


def get_lookup(ctx):
    country = ctx.country
    lang = ctx.lang[0]
    country_and_lang_couple = (country, lang)
    lookup = lookup_by_country_and_lang_couple.get(country_and_lang_couple)
    if lookup is None:
        lookup_by_country_and_lang_couple[country_and_lang_couple] = lookup = mako.lookup.TemplateLookup(
            default_filters = ['h'],
            directories = [
                os.path.join(dir, relative_dir)
                for relative_dir in relative_dirs_by_country_and_lang_couple[country_and_lang_couple]
                ],
            # error_handler = handle_mako_error,
            input_encoding = 'utf-8',
            module_directory = os.path.join(conf['cache_dir'], 'templates', country, lang),
            strict_undefined = False,
            )
    return lookup


def get_template(ctx, template_path):
    assert template_path.startswith('/')
    return get_lookup(ctx).get_template(template_path)


def qp(s, encoding = 'utf-8'):
    assert isinstance(s, unicode)
    quoted_words = []
    for word in s.split(' '):
        try:
            word = str(word)
        except UnicodeEncodeError:
            word = str(email.header.Header(word.encode(encoding), encoding))
        quoted_words.append(word)
    return u' '.join(quoted_words)


def render(ctx, template_path, **kw):
    assert template_path.startswith('/')
    return get_template(ctx, template_path).render_unicode(
        _ = ctx.translator.ugettext,
        ctx = ctx,
        js = js,
        N_ = lambda message: message,
        qp = qp,
        node = None,
        req = ctx.req,
        **kw).strip()


def render_def(ctx, template_path, def_name, **kw):
    assert template_path.startswith('/')
    return get_template(ctx, template_path).get_def(def_name).render_unicode(
        _ = ctx.translator.ugettext,
        ctx = ctx,
        js = js,
        N_ = lambda message: message,
        qp = qp,
        node = None,
        req = ctx.req,
        **kw).strip()
