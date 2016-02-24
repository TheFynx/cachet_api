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
# Under your profile in Cachet, get your api_key from the API Token section.
CachetClient = cachetClient.new(api_key)
```

View the last release API documentation at: [https://docs.cachethq.io/](https://docs.cachethq.io/)

## Development
After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
