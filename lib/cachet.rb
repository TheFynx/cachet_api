require 'rubygems' if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby' && RUBY_VERSION < '2.0'
require 'cachet/rb/version'
require 'rest-client'
require 'uri'
require 'json'

class CachetClient

  class Error < StandardError; end

  STATUS_OPERATIONAL = 1
  STATUS_PERFORMANCE_ISSUES = 2
  STATUS_PARTIAL_OUTAGE = 3
  STATUS_MAJOR_OUTAGE = 4

  INCIDENT_SCHEDULED = 0
  INCIDENT_INVESTIGATING = 1
  INCIDENT_IDENTIFIED = 3
  INCIDENT_WATCHING = 3
  INCIDENT_FIXED = 4

# Providing Demo api/url information if none provided

  def initialize(api_key, base_url)
    @api_key = api_key || ENV['CACHET_API_KEY'] || '9yMHsdioQosnyVK4iCVR'
    @url = base_url || ENV['CACHET_BASE_URL'] || 'https://demo.cachethq.io/api/v1/'
    @headers = {
      'X-Cachet-Token' => @api_key,
      'Content-Type' => 'application/json'
    }
  end

  private

  def request(params)
    response = RestClient::Request.execute(params.merge(:headers => @headers))
    body = JSON.parse(response.body)

    if body['status'] && body['status']['error'] == 'yes'
      raise CachetClient::Error, body['status']['message']
    elsif response.code == 200
      return body
    else
      raise Net::HTTPError, response.inspect
    end
  end

  public

  ##
  # List all component.
  #
  # @return object

  def component_list
    request :method  => :get,
            :url     => @url + 'components/'
  end

  ##
  # List component by id.
  #
  # @param id(int) Numeric component id
  # @return object

  def component_list_id
    request :method  => :get,
            :url     => @url + 'components/' + id
  end

  ##
  # Update the status of a component on the fly without creating an incident or maintenance.
  #
  # @param id(int) Numeric component id
  # @param status(int) Numeric status of the component; 1-4.
  # @return object

  def component_status_update(id, status)
    request :method  => :post,
            :url     => @url + 'components/' + id
            :payload => {
              'id'       => id,
              'status'   => status
            }
  end
