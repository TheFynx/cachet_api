# frozen_string_literal: true

require 'rubygems' if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby' && RUBY_VERSION < '2.0'
require 'cachet/rb/version'
require 'rest-client'
require 'uri'
require 'json'
require_relative 'cachet/components'
require_relative 'cachet/incidents'
require_relative 'cachet/metrics'
require_relative 'cachet/subscribers'

###
# Basic client to call to make calls into rest-client
#
class CachetClient
  ##
  # class to catch errors
  class Error < StandardError; end

  ##
  # Constant to utilize for Component Status Operational
  STATUS_OPERATIONAL = 1
  ##
  # Constant to utilize for Component Status Peformance Issues
  STATUS_PERFORMANCE_ISSUES = 2
  ##
  # Constant to utilize for Component Status Partial Outage
  STATUS_PARTIAL_OUTAGE = 3
  ##
  # Constant to utilize for Component Status Major Outage
  STATUS_MAJOR_OUTAGE = 4

  ##
  # Constant to utilize for Incident Status Scheduled Incident/Maintainence
  INCIDENT_SCHEDULED = 0
  ##
  # Constant to utilize for Incident Status Investigating
  INCIDENT_INVESTIGATING = 1
  ##
  # Constant to utilize for Incident Status Identified
  INCIDENT_IDENTIFIED = 2
  ##
  # Constant to utilize for Incident Status Watching
  INCIDENT_WATCHING = 3
  ##
  # Constant to utilize for Incident Status Fixed
  INCIDENT_FIXED = 4

  ##
  # Providing Demo api/url information if none provided
  # @param api_key [string] :api_key Your cachet API Token/Key
  # @param base_url [string] :base_url Your cachet base api url
  # @return object

  def initialize(api_key, base_url)
    @api_key = api_key
    @base_url = base_url
    @headers = {
      'X-Cachet-Token' => @api_key,
      'Content-Type' => 'application/json'
    }
  end

  ##
  # Posts token, url, headers, and any payloads to rest-client all params are passed by methods
  # @param params [string] :api_key Your cachet API Token/Key
  # @param params [string] :url Your complete cachet api url, built by methods
  # @param params [string] :method Get, Post, Put, and Delete
  # @param params [hash] :options Set of options provided by the Cachet methods
  # @param params [hash] :headers provides by initialize methods
  # @return object

  def request(params)
    headers = params[:headers] ? @headers.merge(params[:headers]) : @headers
    response = RestClient::Request.execute(params.merge(headers: headers))
    code = response.code

    if response.code == 200
      body = JSON.parse(response.body)
      return body
    elsif response.code == 204
      return { 'data' => code }
    else
      fail Net::HTTPError, response.inspect
    end
  end

  ##
  # Ping.
  #
  # @return object

  def ping
    request method:  :get,
            url:     @base_url + 'ping'
  end
end
