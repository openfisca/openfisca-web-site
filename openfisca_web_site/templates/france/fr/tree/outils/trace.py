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


import collections
import json
import urllib2

from openfisca_web_site import conf, contexts, conv, model, wsgihelpers


class Node(model.Page):
    @property
    def routings(self):
        return (
            (('GET', 'POST'), '^/?$', self.trace),
            ) + super(Node, self).routings

    @wsgihelpers.wsgify
    def trace(self, req):
        ctx = contexts.Ctx(req)
        headers = wsgihelpers.handle_cross_origin_resource_sharing(ctx)

        content_type = req.content_type
        if content_type is not None:
            content_type = content_type.split(';', 1)[0].strip()
        if req.method == 'POST' and content_type == 'application/json':
            simulation, error = conv.pipe(
                conv.make_input_to_json(object_pairs_hook = collections.OrderedDict),
                conv.test_isinstance(dict),
                conv.not_none,
                )(req.body, state = ctx)
            if error is not None:
                return wsgihelpers.respond_json(ctx,
                    collections.OrderedDict(sorted(dict(
                        apiVersion = '1.0',
                        error = collections.OrderedDict(sorted(dict(
                            code = 400,  # Bad Request
                            errors = [error],
                            message = ctx._(u'Invalid JSON in request POST body'),
                            ).iteritems())),
                        method = req.script_name,
                        params = req.body,
                        url = req.url.decode('utf-8'),
                        ).iteritems())),
                    headers = headers,
                    )
            api_url = conf['urls.api']
        else:
            # URL-encoded GET or POST.
            params = req.params
            inputs = dict(
                api_url = params.get('api_url'),
                simulation = params.get('simulation'),
                simulation_url = params.get('simulation_url'),
                )
            data, errors = conv.struct(
                dict(
                    api_url = conv.pipe(
                        conv.make_input_to_url(error_if_fragment = True, error_if_path = True, error_if_query = True,
                            full = True),
                        conv.default(conf['urls.api']),
                        ),
                    simulation = conv.pipe(
                        conv.make_input_to_json(object_pairs_hook = collections.OrderedDict),
                        conv.test_isinstance(dict),
                        # When None, use default value defined in atom.mako.
                        ),
                    simulation_url = conv.make_input_to_url(full = True),
                    ),
                )(inputs, state = ctx)
            if errors is not None:
                return wsgihelpers.respond_json(ctx,
                    collections.OrderedDict(sorted(dict(
                        apiVersion = '1.0',
                        context = inputs.get('context'),
                        error = collections.OrderedDict(sorted(dict(
                            code = 400,  # Bad Request
                            errors = [errors],
                            message = ctx._(u'Bad parameters in request'),
                            ).iteritems())),
                        method = req.script_name,
                        params = inputs,
                        url = req.url.decode('utf-8'),
                        ).iteritems())),
                    headers = headers,
                    )
            api_url = data['api_url']
            if data['simulation_url'] is not None:
                request = urllib2.Request(data['simulation_url'], headers = {'User-Agent': 'OpenFisca-Web-Site'})
                try:
                    response = urllib2.urlopen(request)
                except urllib2.HTTPError as response:
                    return wsgihelpers.respond_json(ctx,
                        collections.OrderedDict(sorted(dict(
                            apiVersion = '1.0',
                            context = inputs.get('context'),
                            error = collections.OrderedDict(sorted(dict(
                                code = 400,  # Bad Request
                                errors = [{'code': response.code, 'message': response.msg, 'url': response.url}],
                                message = ctx._(u'Unable to fetch simulation JSON from simulation_url'),
                                ).iteritems())),
                            method = req.script_name,
                            params = inputs,
                            url = req.url.decode('utf-8'),
                            ).iteritems())),
                        headers = headers,
                        )
                response_text = response.read()
                simulation = json.loads(response_text, object_pairs_hook = collections.OrderedDict)
            else:
                simulation = data['simulation']
        simulation_text = json.dumps(simulation, encoding = 'utf-8', ensure_ascii = False, indent = 2) \
            if simulation is not None else None

        response = req.response
        response.headers.update(headers)
        return self.render(api_url = api_url, simulation_text = simulation_text)
