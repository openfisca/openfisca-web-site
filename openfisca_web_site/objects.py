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


"""Base mixins for objects"""


from . import conv


__all__ = ['Initable', 'JsonMonoClassMapper', 'JsonMultiClassMapper']


class Initable(object):
    def __init__(self, **attributes):
        if attributes:
            self.set_attributes(**attributes)

    def set_attributes(self, **attributes):
        """Set given attributes and return a boolean stating whether existing attributes have changed."""
        changed = False
        for name, value in attributes.iteritems():
            if value is getattr(self.__class__, name, UnboundLocalError):
                if value is not getattr(self, name, UnboundLocalError):
                    delattr(self, name)
                    changed = True
            elif value is not getattr(self, name, UnboundLocalError):
                setattr(self, name, value)
                changed = True
        return changed


class JsonMonoClassMapper(object):
    @property
    def attributes_to_json(self):
        return conv.pipe(
            self.rename_attribute_to_json_items,
            conv.struct(
                self.get_attribute_to_json_converters(),
                default = conv.noop,
                skip_missing_items = True,
                ),
            )

    def get_attribute_to_json_converters(self):
        return {}

    @classmethod
    def get_json_to_attribute_converters(cls):
        return {}

    @staticmethod
    def instance_to_json(self, state = None):
        # This method is a static method in order to be a real converter (with two inputs: value & state).
        if self is None:
            return self, None
        if state is None:
            state = conv.default_state
        return conv.pipe(
            self.instance_to_json_attributes,
            self.attributes_to_json,
            )(self, state = state)

    @staticmethod
    def instance_to_json_attributes(self, state = None):
        # This method is a static method in order to be a real converter (with two inputs: value & state).
        if state is None:
            state = conv.default_state
        return conv.object_to_clean_dict(self, state = state)

    @classmethod
    def json_dict_to_attributes(cls, value, state = None):
        if state is None:
            state = conv.default_state
        return conv.pipe(
            conv.struct(
                cls.get_json_to_attribute_converters(),
                # default = None,  # For security reasons, don't accept JSON items without converters.
                skip_missing_items = True,
                ),
            cls.json_dict_to_attributes_phase2,
            cls.rename_json_to_attribute_items,
            )(value, state = state)

    @classmethod
    def json_dict_to_attributes_phase2(cls, value, state = None):
        return value, None

    @classmethod
    def json_to_instance(cls, value, state = None):
        if value is None:
            return value, None
        if state is None:
            state = conv.default_state
        if not isinstance(value, dict):
            return value, state._(u'Expected a dictionary. Got {0}').format(type(value))
        self, error = conv.pipe(
            cls.json_dict_to_attributes,
            conv.make_dict_to_object(cls),
            )(value, state = state)
        if error is not None:
            return self, error
        return self.terminate_json_to_instance(state = state)

    @classmethod
    def rename_attribute_to_json_items(cls, value, state = None):
        return value, None

    @classmethod
    def rename_json_to_attribute_items(cls, value, state = None):
        return value, None

    def terminate_json_to_instance(self, state = None):
        return self, None


class JsonMultiClassMapper(JsonMonoClassMapper):
    # Define ``class_by_slug = {}`` in subclasses.
    json_slug_key = u'class'

    @property
    def attributes_to_json(self):
        return conv.pipe(
            super(JsonMultiClassMapper, self).attributes_to_json,
            conv.condition(
                conv.test(lambda attributes: len(attributes) == 1 and self.json_slug_key in attributes),
                conv.function(lambda attributes: attributes[self.json_slug_key]),
                ),
            )

    def convert_to_json_command(self, state = None):
        for slug, instance_class in self.class_by_slug.iteritems():
            if instance_class is self.__class__:
                return slug, None
        if state is None:
            state = conv.default_state
        return self.__class__.__name__, state._(u'No slug found for multi-class mapper {0}').format(self.__class__)

    @staticmethod
    def instance_to_json_attributes(self, state = None):
        # This method is a static method in order to be a real converter (with two inputs: value & state).
        if self is None:
            return self, None
        if state is None:
            state = conv.default_state

        def add_class_to_attributes(attributes, state = None):
            if attributes is None:
                return attributes, None
            if state is None:
                state = conv.default_state
            attributes[self.json_slug_key], error = self.convert_to_json_command(state = state)
            if error is not None:
                return attributes, {self.json_slug_key: error}
            return attributes, None

        return conv.pipe(
            super(JsonMultiClassMapper, self).instance_to_json_attributes,
            add_class_to_attributes,
            )(self, state = state)

    @classmethod
    def json_to_instance(cls, value, state = None):
        if value is None:
            return value, None
        if state is None:
            state = conv.default_state
        if isinstance(value, basestring):
            instance_class = cls.class_by_slug.get(value)
            json_dict = {}
        elif isinstance(value, dict):
            json_dict = value.copy()
            slug = json_dict.pop(cls.json_slug_key, None)
            if slug is None:
                return value, state._(u'Missing "class" item')
            instance_class = cls.class_by_slug.get(slug)
        else:
            return value, state._(u'Expected a dictionary. Got {0}').format(type(value))
        if instance_class is None:
            return value, state._(u'Unknown value')
        self, error = conv.pipe(
            instance_class.json_dict_to_attributes,
            conv.make_dict_to_object(instance_class),
            )(json_dict, state = state)
        if error is not None:
            return self, error
        return self.terminate_json_to_instance(state = state)
