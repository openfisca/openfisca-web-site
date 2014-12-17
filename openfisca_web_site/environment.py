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


"""Environment configuration"""


import logging
import os
import sys

from biryani import strings

import openfisca_web_site
from . import conv, model, templates


app_dir = os.path.dirname(os.path.abspath(__file__))


def load_environment(global_conf, app_conf):
    """Configure the application environment."""
    conf = openfisca_web_site.conf  # Empty dictionary
    conf.update(strings.deep_decode(global_conf))
    conf.update(strings.deep_decode(app_conf))
    conf.update(conv.check(conv.struct(
        {
            'app_conf': conv.set_value(app_conf, handle_none_value = True),
            'app_dir': conv.set_value(app_dir, handle_none_value = True),
            'cache_dir': conv.default(os.path.join(os.path.dirname(app_dir), 'cache')),
            'cookie': conv.default('openfisca_web_site'),
            'custom_templates_dir': conv.pipe(
                conv.empty_to_none,
                conv.test(os.path.exists),
                ),
            'customs_dir': conv.default(None),
            'debug': conv.pipe(conv.guess_bool, conv.default(False)),
            'global_conf': conv.set_value(global_conf, handle_none_value = True),
            'google_analytics.key': conv.empty_to_none,
            'host_urls': conv.pipe(
                conv.function(lambda host_urls: host_urls.split()),
                conv.uniform_sequence(
                    conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                        full = True, schemes = (u'ws', u'wss')),
                    constructor = lambda host_urls: sorted(set(host_urls)),
                    ),
                ),
            'i18n_dir': conv.default(os.path.join(app_dir, 'i18n')),
            'languages': conv.pipe(
                conv.cleanup_line,
                conv.function(lambda value: value.split(',')),
                conv.uniform_sequence(conv.input_to_slug),
                ),
            'log_level': conv.pipe(
                conv.default('WARNING'),
                conv.function(lambda log_level: getattr(logging, log_level.upper())),
                ),
            'package_name': conv.default('openfisca-web-site'),
            'piwik.key': conv.input_to_int,
            'piwik.url': conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                full = True),
            'realm': conv.default(u'OpenFisca-Web-Site'),
            # Whether this application serves its own static files.
            'static_files': conv.pipe(conv.guess_bool, conv.default(True)),
            'static_files_dir': conv.default(os.path.join(app_dir, 'static')),
            'twitter.access_token_key': conv.cleanup_line,
            'twitter.access_token_secret': conv.cleanup_line,
            'twitter.consumer_key': conv.cleanup_line,
            'twitter.consumer_secret': conv.cleanup_line,
            'urls.api': conv.pipe(
                conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                    full = True),
                conv.not_none,
                ),
            'urls.ui': conv.pipe(
                conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                    full = True),
                conv.not_none,
                ),
            'urls.other_www_by_country': conv.pipe(
                conv.cleanup_line,
                conv.function(lambda value: value.split('\n')),
                conv.uniform_sequence(
                    conv.pipe(
                        conv.function(lambda value: value.split('=')),
                        conv.uniform_sequence(conv.cleanup_line),
                        )
                    ),
                conv.function(lambda value: dict(value)),
                conv.uniform_mapping(
                    conv.noop,
                    conv.pipe(
                        conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                            full = True),
                        conv.not_none,
                        )
                    ),
                ),
            },
        default = 'drop',
        ))(conf))

    # Configure logging.
    logging.basicConfig(level = conf['log_level'], stream = sys.stderr)

    errorware = conf.setdefault('errorware', {})
    errorware['debug'] = conf['debug']
    if not errorware['debug']:
        errorware['error_email'] = conf['email_to']
        errorware['error_log'] = conf.get('error_log', None)
        errorware['error_message'] = conf.get('error_message', 'An internal server error occurred')
        errorware['error_subject_prefix'] = conf.get('error_subject_prefix', 'OpenFisca-Web-Site Error: ')
        errorware['from_address'] = conf['from_address']
        errorware['smtp_server'] = conf.get('smtp_server', 'localhost')

    # Create the Mako TemplateLookup, with the default auto-escaping.
    templates.dir = os.path.join(app_dir, 'templates')


def setup_environment():
    """Setup the application environment (after it has been loaded)."""
    # conf = openfisca_web_site.conf

    # Setup MongoDB database.
    model.setup()
