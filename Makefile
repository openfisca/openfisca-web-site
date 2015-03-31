.PHONY: clean flake8

all: flake8

clean:
	rm -Rf cache/templates/
	find . -name '*.pyc' -exec rm \{\} \;

ctags:
	ctags --recurse=yes --exclude=cache --exclude=docker --exclude=openfisca_web_site/static --exclude=OpenFisca_Web_Site.egg-info .

flake8: clean
	flake8 .
