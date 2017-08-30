# OpenFisca Web-Site

[OpenFisca](http://www.openfisca.fr/) is a versatile microsimulation free software.  
This is the source code of the [Web-Site](http://www.openfisca.fr/).

For more information, please consult http://openfisca.org/doc/

## Install procedure

To install and serve the OpenFisca France website locally using a package manager like `brew`:

A/ Install the following packages:

```SH
pip install pastescript
brew install libmagic
brew install bower
```

B/ Run the following commands:

```SH
pip install -e .
bower install
```

C/ Serve locally:

`paster serve development-france.ini`
Visit `http://127.0.0.1:2010` to see the website.
