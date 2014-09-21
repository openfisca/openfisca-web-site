# What is OpenFisca-Web-Site?

OpenFisca is a simulator for the tax-benefit systems of several countries.

OpenFisca-Web-Site is the Docker image of the Git repository of the web site that presents OpenFisca in several languages and for several countries.


## Launch a local image of the french site [www.openfisca.fr](http://www.openfisca.fr/)

```
docker run -d -p 2016:2016 openfisca/openfisca-web-site:latest 
```

or

```
docker run -d -p 2016:2016 openfisca/openfisca-web-site:latest paster serve /src/openfisca-web-site/development-france.ini
```


## Launch a local image of the tunisian site [www.openfisca.tn](http://www.openfisca.tn/)

```
docker run -d -p 2016:2016 openfisca/openfisca-web-site:latest paster serve /src/openfisca-web-site/development-tunisia.ini
```

