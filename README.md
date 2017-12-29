# README

## Set up

This repo uses scripts to set up, taken from [github unified scripts](https://githubengineering.com/scripts-to-rule-them-all/)

Before running any of these scripts it is assumed the following is installed:

```
ruby (possibly with rbenv or RVM)
bundler
postgres
```

If those are installed the dependencies and database can be set up by running:

```shell
script/bootstrap
script/setup
```

Other commands available:

```shell
script/update # updates dependencies and runs db migrations
script/console # starts a rails console
script/server # starts the rails server
script/test # runs the test suite
```

## Deployment

Anything merged into master is automatically deployed via Heroku. Pull requests should be used, and CircleCI tests need to pass in order to merge.

The app is available at:
app.loggingprogress.com
