# Cachet API Library Wrapper
[![Travis CI](https://travis-ci.org/TheFynx/cachet_api.svg)](https://travis-ci.org/TheFynx/cachet_api) [![Code Climate](https://codeclimate.com/github/TheFynx/cachet_api/badges/gpa.svg)](https://codeclimate.com/github/TheFynx/cachet_api) [![Test Coverage](https://codeclimate.com/github/TheFynx/cachet_api/badges/coverage.svg)](https://codeclimate.com/github/TheFynx/cachet_api/coverage) [![Issue Count](https://codeclimate.com/github/TheFynx/cachet_api/badges/issue_count.svg)](https://codeclimate.com/github/TheFynx/cachet_api) [![Inline docs](http://inch-ci.org/github/thefynx/cachet_api.svg?branch=master)](http://inch-ci.org/github/thefynx/cachet_api)

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
CachetComponents = CachetComponents.new(api_key, base_url)
CachetIncidents = CachetIncidents.new(api_key, base_url)
CachetMetrics = CachetMetrics.new(api_key, base_url)
CachetSubscribers = CachetSubscribers.new(api_key, base_url)
```

View the last release API documentation at: [https://docs.cachethq.io/](https://docs.cachethq.io/)

## Library to API Quick Reference
### Ping

Cachet API | Ruby Library
:--------- | :----------------
get/ping   | CachetClient.ping

### Components

Cachet API                   | Ruby Library
:--------------------------- | :------------------------------
get/components               | CachetComponents.list
get/components/:id           | CachetComponents.list_id
post/components              | CachetComponents.create
put/components/:id           | CachetComponents.update
delete/components/:id        | CachetComponents.delete
get/components/groups        | CachetComponents.groups_list
get/components/groups/:id    | CachetComponents.groups_list_id
post/components/groups       | CachetComponents.groups_create
put/components/groups/:id    | CachetComponents.groups_update
delete/components/groups/:id | CachetComponents.groups_delete

### Incidents

Cachet API           | Ruby Library
:------------------- | :----------------------
get/incidents        | CachetIncidents.list
get/incidents/:id    | CachetIncidents.list_id
post/incidents       | CachetIncidents.create
put/incidents/:id    | CachetIncidents.update
delete/incidents/:id | CachetIncidents.delete

### Metrics

Cachet API                          | Ruby Library
:---------------------------------- | :-------------------------
get/metrics                         | CachetMetrics.list
post/metrics                        | CachetMetrics.create
get/metrics/:id                     | CachetMetrics.list_id
delete/metrics/:id                  | CachetMetrics.delete
get/metrics/:id/points              | CachetMetrics.point_list
post/metrics/:id/points             | CachetMetrics.point_add
delete/metrics/:id/points/:point_id | CachetMetrics.point_delete

### Subscribers

Cachet API             | Ruby Library
:--------------------- | :-----------------------
get/subscribers        | CachetSubscribers.list
post/subscribers       | CachetSubscribers.create
delete/subscribers/:id | CachetSubscribers.delete

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
