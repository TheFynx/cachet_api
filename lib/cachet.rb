require 'rubygems' if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby' && RUBY_VERSION < '2.0'
require 'cachet/rb/version'
require 'rest-client'
require 'uri'
require 'json'

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
  INCIDENT_IDENTIFIED = 3
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
  # @param api_key [string] :api_key Your cachet API Token/Key
  # @param url [string] :url Your complete cachet api url, built by methods
  # @param method [string] :method Get, Post, Put, and Delete
  # @param payload [hash] :options Set of options provided by the Cachet methods
  # @param headers [hash] :headers provides by initialize methods
  # @return object

  def request(params)
    response = RestClient::Request.execute(params.merge(headers: @headers))
    code = response.code

    if response.code == 200
      body = JSON.parse(response.body)
      return body
    elsif response.code == 204
      return code
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

###
# Inherits CachetClient and handles all Components API Calls
#
class CachetComponents < CachetClient
  ##
  # List all Components.
  #
  # @return object

  def list
    request method:  :get,
            url:     @base_url + 'components'
  end

  ##
  # List Component by ID.
  # @option options [string] :id Numeric component id
  # @return object
  # id

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'components/' + options['id']
  end

  ##
  # Create Component.
  #
  # @option options [string] :name **Required** Component name
  # @option options [int] :status **Required** Numeric status of the component; 1-4
  # @option options [string] :description Description of the component
  # @option options [string] :link A hyperlink to the component
  # @option options [int] :order Numeric order of the component
  # @option options [int] :group_id Numeric group id component is within
  # @option options [boolean] :enabled True/False to enable/disable component
  # @return object

  def create(options)
    request method:  :post,
            url:     @base_url + 'components',
            payload: options
  end

  ##
  # Update Component.
  #
  # @option options [string] :id **Required** Numeric component id
  # @option options [int] :status **Required** Numeric status of the component; 1-4
  # @option options [string] :name **Required** Component name
  # @option options [string] :link A hyperlink to the component
  # @option options [int] :order Numeric order of the component
  # @option options [int] :group_id Numeric group id component is within
  # @option options [boolean] :enabled True/False to enable/disable component
  # @return object

  def update(options)
    request method:  :put,
            url:     @base_url + 'components/' + options['id'],
            payload: options
  end

  ##
  # Delete Component.
  #
  # @option options [string] :id **Required** Numeric component id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'components/' + options['id']
  end

  ##
  # List all Component Groups.
  #
  # @return object

  def groups_list
    request method:  :get,
            url:     @base_url + 'components/groups'
  end

  ##
  # List Component Group by ID.
  #
  # @option options [string] :id **Required** Numeric component group id
  # @return object

  def groups_list_id(options)
    request method:  :get,
            url:     @base_url + 'components/groups/' + options['id']
  end

  ##
  # Create Component Group.
  #
  # @option options [string] :name **Required** Component group name
  # @option options [int] :order Numeric order of the component group
  # @option options [boolean] :collapsed Whether to collapse the group by default
  # @return object

  def groups_create(options)
    request method:  :post,
            url:     @base_url + 'components/groups',
            payload: options
  end

  ##
  # Update Component Group.
  #
  # @option options [string] :id **Required** Numeric component group id
  # @option options [string] :name Component group name
  # @option options [int] :order Numeric order of the component group
  # @option options [boolean] :collapsed Whether to collapse the group by default
  # @return object

  def groups_update(options)
    request method:  :put,
            url:     @base_url + 'components/groups',
            payload: options
  end

  ##
  # Delete Component Group.
  #
  # @option options [string] :id **Required** Numeric component group id
  # @return object

  def groups_delete(options)
    options['id'].each_pair do |_k, v|
      options['id'] = v.to_s
    end
    request method:  :delete,
            url:     @base_url + 'components/groups/' + options['id']
  end
end

###
# Inherits CachetClient and handles all Incidents API Calls
#
class CachetIncidents < CachetClient
  ##
  # List all Incidents.
  #
  # @return object

  def list
    request method:  :get,
            url:     @base_url + 'incidents'
  end

  ##
  # List Incident by ID.
  #
  # @option options [string] :id Numeric incident id
  # @return object

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'incidents/' + options['id']
  end

  ##
  # Create Incident.
  #
  # @option options [string] :name **Required** Incident name
  # @option options [string] :message **Required** Description of the incident
  # @option options [int] :status **Required** Status of the incident; 1-4
  # @option options [int] :visible **Required** value whether the incident public 0/1
  # @option options [int] :component_id Component to update.(Required with component_status)
  # @option options [int] :component_status The status to update the given component with.
  # @option options [boolean] :notify True/False Whether to notify subscribers.
  # @return object

  def create(options)
    request method:  :post,
            url:     @base_url + 'incidents',
            payload: options
  end

  ##
  # Update Incident.
  #
  # @option options [string] :id Numeric incident id
  # @option options [string] :name Incident name
  # @option options [string] :message  Description of the incident
  # @option options [int] :status Status of the incident; 1-4
  # @option options [int] :visible value whether the incident public 0/1
  # @option options [int] :component_id Component to update.(Required with component_status)
  # @option options [int] :component_status The status to update the given component with.
  # @option options [boolean] :notify True/False Whether to notify subscribers.
  # @return object

  def update(options)
    request method:  :put,
            url:     @base_url + 'incidents/' + options['id'],
            payload: options
  end

  ##
  # Delete Incident.
  #
  # @option options [string] :id Numeric incident id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'incidents/' + options['id']
  end
end

###
# Inherits CachetClient and handles all Metrics API Calls
#
class CachetMetrics < CachetClient
  ##
  # List all Metrics.
  #
  # @return object

  def list
    request method:  :get,
            url:     @base_url + 'metrics'
  end

  ##
  # Create Metric.
  #
  # @option options [string] :name **Required** Metric name
  # @option options [string] :suffix **Required** Measurments in
  # @option options [string] :description **Required** Description of what is measured
  # @option options [int] :default_value **Required** The default value for points
  # @option options [int] :display_chart Whether to display the chart on the status page
  # @return object

  def create(options)
    request method:  :post,
            url:     @base_url + 'metrics',
            payload: options
  end

  ##
  # List Metric by ID Without Points.
  #
  # @option options [string] :id Numeric Metric id
  # @return object

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'metrics/' + options['id']
  end

  ##
  # Delete a Metric.
  #
  # @option options [string] :id Numeric Metric id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'metrics/' + options['id']
  end

  ##
  # List Metric Points.
  #
  # @option options [string] :id Numeric Metric id
  # @return object

  def point_list(options)
    request method:  :get,
            url:     @base_url + 'metrics/' + options['id'] + '/points'
  end

  ##
  # Add Metric Point.
  #
  # @option options [string] :id Numeric Metric id
  # @option options [int] :value **Required** Value to plot on the metric graph
  # @option options [string] :timestamp Unix timestamp of the point was measured
  # @return object

  def point_add(options)
    request method:  :post,
            url:     @base_url + 'metrics/' + options['id'] + '/points',
            payload: options
  end

  ##
  # Delete Metric Point.
  #
  # @option options [string] :id Numeric Metric id
  # @option options [int] :point_id **Required** Metric Point id
  # @return object

  def point_delete(options)
    request method:  :delete,
            url:     @base_url + 'metrics/' + options['id'] + '/points/' + options['point_id'],
            payload: options
  end
end

###
# Inherits CachetClient and handles all Subscribers API Calls
#
class CachetSubscribers < CachetClient
  ##
  # List all Subscribers.
  #
  # @return object

  def list
    request method:  :get,
            url:     @base_url + 'subscribers'
  end

  ##
  # Create Subscriber.
  #
  # @option options [string] :email **Required** Email address to subscribe
  # @option options [int] :verify Whether to send verification email 0/1
  # @return object

  def create(options)
    request method:  :post,
            url:     @base_url + 'subscribers',
            payload: options
  end

  ##
  # Delete a Subscriber.
  #
  # @option options [string] :id ID of the subscriber to delete
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'subscribers/' + options['id']
  end
end
