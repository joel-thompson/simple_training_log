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
script/sidekiq # runs sidekiq
script/redis # runs redis
```

## Starting the server locally

Sidekiq is used for background tasks, which means redis and sidekiq should be running locally alongside the rails server.

The three scripts here should be run:

```
script/redis
script/sidekiq
script/server
```

## Deployment

Anything merged into master is automatically deployed via Heroku. Pull requests should be used, and CircleCI tests need to pass in order to merge.

The app is available at:
[app.loggingprogress.com](https://app.loggingprogress.com)
