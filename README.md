# Cachet API Library Wrapper
[![Travis CI](https://travis-ci.org/TheFynx/cachet_api.svg)](https://travis-ci.org/TheFynx/cachet_api) [![Code Climate](https://codeclimate.com/github/TheFynx/cachet_api/badges/gpa.svg)](https://codeclimate.com/github/TheFynx/cachet_api) [![Test Coverage](https://codeclimate.com/github/TheFynx/cachet_api/badges/coverage.svg)](https://codeclimate.com/github/TheFynx/cachet_api/coverage) [![Issue Count](https://codeclimate.com/github/TheFynx/cachet_api/badges/issue_count.svg)](https://codeclimate.com/github/TheFynx/cachet_api) [![Inline docs](http://inch-ci.org/github/thefynx/cachet_api.svg?branch=master)](http://inch-ci.org/github/thefynx/cachet_api) [![Gem](https://img.shields.io/gem/v/cachet_api.svg)](https://rubygems.org/gems/cachet_api) [![Gem](https://img.shields.io/gem/dt/cachet_api.svg)](https://rubygems.org/gems/cachet_api)

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
See [RubyDoc](http://www.rubydoc.info/github/TheFynx/cachet_api) for more in-depth documentation

### Ping

Cachet API | Ruby Library      | Options/Params
:--------- | :---------------- | :-------------
get/ping   | CachetClient.ping | N/A            |

### Components

Cachet API                   | Ruby Library                    | Options/Params (R) == Required
:--------------------------- | :------------------------------ | :-------------------------------------------------------------------------------
get/components               | CachetComponents.list           | N/A                                                                              |
get/components/:id           | CachetComponents.list_id        | Options (hash) : id                                                              |
post/components              | CachetComponents.create         | Options (hash) : name(R), status(R), description, link, order, group_id, enabled |
put/components/:id           | CachetComponents.update         | Options (hash) : id(R), status(R), name(R), link, order, group_id, enabled       |
delete/components/:id        | CachetComponents.delete         | Options (hash) : id(R)                                                           |
get/components/groups        | CachetComponents.groups_list    | N/A                                                                              |
get/components/groups/:id    | CachetComponents.groups_list_id | Options (hash) : id(R)                                                           |
post/components/groups       | CachetComponents.groups_create  | Options (hash) : name(R), order, collapsed(R)                                    |
put/components/groups/:id    | CachetComponents.groups_update  | Options (hash) : id(R), name, order, collapsed                                   |
delete/components/groups/:id | CachetComponents.groups_delete  | Options (hash) : id(R)                                                           |

### Incidents

Cachet API           | Ruby Library            | Options/Params (R) == Required
:------------------- | :---------------------- | :--------------------------------------------------------------------------------------------------
get/incidents        | CachetIncidents.list    | N/A                                                                                                 |
get/incidents/:id    | CachetIncidents.list_id | Options (hash) : id                                                                                 |
post/incidents       | CachetIncidents.create  | Options (hash) : name(R), message(R), status(R), visible(R), component_id, component_status, notify |
put/incidents/:id    | CachetIncidents.update  | Options (hash) : id(R), name, message, status, visible, component_id, component_status, notify      |
delete/incidents/:id | CachetIncidents.delete  | Options (hash) : id                                                                                 |

### Metrics

Cachet API                          | Ruby Library               | Options/Params (R) == Required
:---------------------------------- | :------------------------- | :--------------------------------------------------------------------------------------
get/metrics                         | CachetMetrics.list         | N/A                                                                                     |
post/metrics                        | CachetMetrics.create       | Options (hash) : name(R), suffix(R), description(R), default_value(R), display_chart(R) |
get/metrics/:id                     | CachetMetrics.list_id      | Options (hash) : id(R)                                                                  |
delete/metrics/:id                  | CachetMetrics.delete       | Options (hash) : id(R)                                                                  |
get/metrics/:id/points              | CachetMetrics.point_list   | Options (hash) : id (R)                                                                 |
post/metrics/:id/points             | CachetMetrics.point_add    | Options (hash) : id(R), value(R), timestamp                                             |
delete/metrics/:id/points/:point_id | CachetMetrics.point_delete | Options (hash) : id(R), point_id(R)                                                     |

### Subscribers

Cachet API             | Ruby Library             | Options/Params
:--------------------- | :----------------------- | :--------------------------------
get/subscribers        | CachetSubscribers.list   | N/A                               |
post/subscribers       | CachetSubscribers.create | Options (hash) : email(R), verify |
delete/subscribers/:id | CachetSubscribers.delete | Options (hash) : id(R)            |

## Development
After checking out the repo
- Run `bin/setup`
- To run IRB with quick configuration, `rake console`
- To install this gem onto your local machine, run `bundle exec rake install`

## Contribute
Fork this repo
- Make your changes
- Create/Update RSPEC Tests
- Document changes inline (if needed, aka new options)
- Document readme with changes
- Submit pull request
