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


"""Root controllers"""


import logging

from . import contexts, model, urls

import webob


log = logging.getLogger(__name__)
router = None


def make_router():
    """Return a WSGI application that searches requests to controllers """
    global router
    router = urls.make_router(
        # ('GET', '^/login/?$', login),
        # ('GET', '^/login-done/?$', login_done),
        # ('GET', '^/logout/?$', logout),
        (None, '', route_node),
        )
    return router


def route_node(environ, start_response):
    req = webob.Request(environ)
    ctx = contexts.Ctx(req)

    ctx.root_node = folder = model.Folder.from_node(ctx)
    return folder.route(environ, start_response)
