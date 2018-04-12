# OpenFisca website - DEPRECATED

## This website is deprecated

**The new OpenFisca France website is now [fr.openfisca.org](https://github.com/openfisca/fr.openfisca.org).**
**This website isn't maintained anymore.**

This website presents a lot of issues, among them:

- Outdated information
- Broken links
- Bugs

You can take a look at the discussion [here](https://github.com/openfisca/openfisca-france/issues/824) (in French)

## Introduction

[OpenFisca](http://www.openfisca.fr/) is a versatile microsimulation free software.
This is the source code of the (now deprecated) [http://www.openfisca.fr/](http://www.openfisca.fr/) website.

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
