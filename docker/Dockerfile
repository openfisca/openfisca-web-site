FROM debian:unstable
# MAINTAINER OpenFisca Team <contact@openfisca.fr>
RUN apt-get update && apt-get upgrade -y
RUN apt-get install --no-install-recommends -y git nodejs-legacy npm python-babel python-lxml python-magic python-mako python-pastedeploy python-pip python-twitter python-weberror python-webob
RUN pip install twitter-text-python
RUN pip install -e git+https://github.com/etalab/biryani.git@biryani1#egg=Biryani1
RUN pip install -e git+https://github.com/openfisca/openfisca-web-site.git#egg=OpenFisca-Web-Site
RUN npm install -g bower
RUN cd /src/openfisca-web-site/ && bower install --allow-root

RUN apt-get install --no-install-recommends -y python-pastescript
RUN sed -e "s/host = 127.0.0.1/host = 0.0.0.0/" /src/openfisca-web-site/development.ini > /src/openfisca-web-site/development-france.ini
RUN sed -e "s/default_country = france/default_country = tunisia/" -e "s/default_language = fr/default_language = ar/" /src/openfisca-web-site/development-france.ini > /src/openfisca-web-site/development-tunisia.ini
CMD paster serve /src/openfisca-web-site/development-france.ini
EXPOSE 2016
