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

from openfisca_web_site import contexts, conv, model, wsgihelpers


class Node(model.Page):
    @property
    def routings(self):
        return super(Node, self).routings + (
            ('POST', '^/?$', self.submit),
            )

    @wsgihelpers.wsgify
    def submit(self, req):
        ctx = contexts.Ctx(req)
        headers = wsgihelpers.handle_cross_origin_resource_sharing(ctx)

        assert req.method == 'POST', req.method

        content_type = req.content_type
        if content_type is not None:
            content_type = content_type.split(';', 1)[0].strip()
        if content_type == 'application/json':
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
        else:
            # URL-encoded POST.
            params = req.POST
            inputs = dict(
                simulation = params.get('simulation'),
                )
            data, errors = conv.struct(
                dict(
                    simulation = conv.pipe(
                        conv.make_input_to_json(object_pairs_hook = collections.OrderedDict),
                        conv.test_isinstance(dict),
                        conv.not_none,
                        ),
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
            simulation = data['simulation']
        simulation_text = unicode(json.dumps(simulation, encoding = 'utf-8', ensure_ascii = False, indent = 2))

        response = req.response
        response.headers.update(headers)
        return self.render(simulation_text = simulation_text)
