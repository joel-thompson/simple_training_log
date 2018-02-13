# Logging Progress

This is a web application that can be used to log excercise. At this time it supports martial arts classes, and weight lifting. 

The app is available at:
[app.loggingprogress.com](https://app.loggingprogress.com), feel free to sign up and check it out!

## Technologies

I'm using the following in this app: 

[Bulma](https://bulma.io/) as the CSS framework

[RSpec](https://github.com/rspec/rspec-rails) for testing

[Heroku](https://www.heroku.com/) with the GitHub integration for hosting/deployment

[Sidekiq](https://github.com/mperham/sidekiq) for background job processing

[CircleCI](https://circleci.com/) for continuous integration

[Intercom](https://www.intercom.com/) for user facing messaging

# Development

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

Anything merged into master is automatically deployed. Pull requests should be used, and CircleCI tests need to pass in order to merge.

