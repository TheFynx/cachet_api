# Cachet API Library Wrapper
## This is under development and not functional
Ruby library wrapper for CachetHQ.io

[![Travis CI](https://travis-ci.org/thefynx/cachet_api.svg)](https://travis-ci.org/thefynx/cachet_api) [![Code Climate](https://codeclimate.com/github/TheFynx/cachet_api/badges/gpa.svg)](https://codeclimate.com/github/TheFynx/cachet_api) [![Test Coverage](https://codeclimate.com/github/TheFynx/cachet_api/badges/coverage.svg)](https://codeclimate.com/github/TheFynx/cachet_api/coverage) [![Issue Count](https://codeclimate.com/github/TheFynx/cachet_api/badges/issue_count.svg)](https://codeclimate.com/github/TheFynx/cachet_api)

Ruby library wrapper for [CachetHQ.io](https://cachethq.io)

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'cachet_api'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install cachet_api
```

## Usage

```ruby
# Under your profile in Cachet, get your api_key from the API Token section. Base url is https://demo.cachethq.io/api/v1/ or https://cachet.yourdomain.com/api/v1/
CachetClient = CachetClient.new(api_key, base_url)
```

View the last release API documentation at: [https://docs.cachethq.io/](https://docs.cachethq.io/)

## Library to API Quick Reference
### Ping

Cachet API | Ruby Library
:--------- | :----------------
get/ping   | CachetClient.ping

### Components

Cachet API                   | Ruby Library
:--------------------------- | :-------------------------------------
get/components               | CachetClient.components_list
get/components/:id           | CachetClient.components_list_id
post/components              | CachetClient.components_create
put/components/:id           | CachetClient.components_update
delete/components/:id        | CachetClient.components_delete
get/components/groups        | CachetClient.components_groups_list
get/components/groups/:id    | CachetClient.components_groups_list_id
post/components/groups       | CachetClient.components_groups_create
put/components/groups/:id    | CachetClient.components_groups_update
delete/components/groups/:id | CachetClient.components_groups_delete

### Incidents

Cachet API           | Ruby Library
:------------------- | :-----------------------------
get/incidents        | CachetClient.incidents_list
get/incidents/:id    | CachetClient.incidents_list_id
post/incidents       | CachetClient.incidents_create
put/incidents/:id    | CachetClient.incidents_update
delete/incidents/:id | CachetClient.incidents_delete

### Metrics

Cachet API                          | Ruby Library
:---------------------------------- | :--------------------------------
get/metrics                         | CachetClient.metrics_list
post/metrics                        | CachetClient.metrics_create
get/metrics/:id                     | CachetClient.metrics_list_id
delete/metrics/:id                  | CachetClient.metrics_delete
get/metrics/:id/points              | CachetClient.metrics_point_list
post/metrics/:id/points             | CachetClient.metrics_point_add
delete/metrics/:id/points/:point_id | CachetClient.metrics_point_delete

### Subscribers

Cachet API             | Ruby Library
:--------------------- | :------------------------------
get/subscribers        | CachetClient.subscribers_list
post/subscribers       | CachetClient.subscribers_create
delete/subscribers/:id | CachetClient.subscribers_delete

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
