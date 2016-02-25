require 'rubygems' if defined?(RUBY_ENGINE) && RUBY_ENGINE == 'ruby' && RUBY_VERSION < '2.0'
require 'cachet/rb/version'
require 'rest-client'
require 'uri'
require 'json'

###
# Basic client to call to make calls into rest-client
#
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

  ##
  # Providing Demo api/url information if none provided

  def initialize(api_key, base_url)
    @api_key = api_key || ENV['CACHET_API_KEY'] || '9yMHsdioQosnyVK4iCVR'
    @base_url = base_url || ENV['CACHET_BASE_URL'] || 'https://demo.cachethq.io/api/v1/'
    @headers = {
      'X-Cachet-Token' => @api_key,
      'Content-Type' => 'application/json'
    }
  end

  def request(params)
    response = RestClient::Request.execute(params.merge(headers: @headers))
    body = JSON.parse(response.body)

    if body['status'] && body['status']['error'] == 'yes'
      fail CachetClient::Error, body['status']['message']
    elsif response.code == 200
      return body
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
#
#
class CachetComponents
  ##
  # List all Components.
  #
  # @return object

  def list
    CachetClient.request method:  :get,
                         url:     @base_url + 'components'
  end

  ##
  # List Component by ID.
  #
  # @option id(int) Numeric component id
  # @return object
  # id

  def list_id(options)
    CachetClient.request method:  :get,
                         url:     @base_url + 'components/' + options[id]
  end

  ##
  # Create Component.
  #
  # @option name(string) **Required** Component name
  # @option status(int) **Required** Numeric status of the component; 1-4
  # @option description(string) Description of the component
  # @option link(string) A hyperlink to the component
  # @option order(int) Numeric order of the component
  # @option group_id(int) Numeric group id component is within
  # @option enabled(boolean) True/False to enable/disable component
  # @return object
  # name, status, description, link, order, group_id, enabled

  def create(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'components',
                         payload: options
  end

  ##
  # Update Component.
  #
  # @option id(int) **Required** Numeric component id
  # @option status(int) Numeric status of the component; 1-4
  # @option name(string) Component name
  # @option link(string) A hyperlink to the component
  # @option order(int) Numeric order of the component
  # @option group_id(int) Numeric group id component is within
  # @return object
  # id, status, name, link, order, group_id

  def update(options)
    CachetClient.request method:  :put,
                         url:     @base_url + 'components/' + options[id],
                         payload: options
  end

  ##
  # Delete Component.
  #
  # @option id(int) **Required** Numeric component id
  # @return object
  # id

  def delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'components/' + options[id]
  end

  ##
  # List all Component Groups.
  #
  # @return object

  def groups_list
    CachetClient.request method:  :get,
                         url:     @base_url + 'components/groups'
  end

  ##
  # List Component Group by ID.
  #
  # @option id(int) **Required** Numeric component group id
  # @return object
  # id

  def groups_list_id(options)
    CachetClient.request method:  :get,
                         url:     @base_url + 'components/groups/' + options[id]
  end

  ##
  # Create Component Group.
  #
  # @option name(string) **Required** Component group name
  # @option order(int) Numeric order of the component group
  # @option collapsed(boolean) Whether to collapse the group by default
  # @return object
  # name, order, collapsed

  def groups_create(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'components/groups',
                         payload: options
  end

  ##
  # Update Component Group.
  #
  # @option id(int) **Required** Numeric component group id
  # @option name(string) Component group name
  # @option order(int) Numeric order of the component group
  # @option collapsed(boolean) Whether to collapse the group by default
  # @return object
  # id, name, order, collapsed

  def groups_update(options)
    CachetClient.request method:  :put,
                         url:     @base_url + 'components/groups',
                         payload: options
  end

  ##
  # Delete Component Group.
  #
  # @option id(int) **Required** Numeric component group id
  # @return object
  # id

  def groups_delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'components/groups/' + options[id]
  end
end

###
#
#
class CachetIncidents
  ##
  # List all Incidents.
  #
  # @return object

  def list
    CachetClient.request method:  :get,
                         url:     @base_url + 'incidents'
  end

  ##
  # List Incident by ID.
  #
  # @option id(int) Numeric incident id
  # @return object
  # id

  def list_id(options)
    CachetClient.request method:  :get,
                         url:     @base_url + 'incidents/' + options[id]
  end

  ##
  # Create Incident.
  #
  # @option name(string) **Required** Incident name
  # @option message(string) **Required** Description of the incident
  # @option status(int) **Required** Status of the incident; 1-4
  # @option visible(int) **Required** value whether the incident public 0/1
  # @option component_id(int)Component to update.(Required with component_status)
  # @option component_status(int) The status to update the given component with.
  # @option notify(boolean) True/False Whether to notify subscribers.
  # @return object
  # name, message, status, visible, component_id, component_status, notify

  def create(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'incidents',
                         payload: options
  end

  ##
  # Update Incident.
  #
  # @option name(string) Incident name
  # @option message(string) Description of the incident
  # @option status(int) Status of the incident; 1-4
  # @option visible(int) value whether the incident public 0/1
  # @option component_id(int)Component to update.(Required with component_status)
  # @option component_status(int) The status to update the given component with.
  # @option notify(boolean) True/False Whether to notify subscribers.
  # @return object
  # id, status, name, message, visible, component_id, component_status, notify

  def update(options)
    CachetClient.request method:  :put,
                         url:     @base_url + 'incidents/' + options[id],
                         payload: options
  end

  ##
  # Delete Incident.
  #
  # @option id(int) **Required** Numeric incident id
  # @return object
  # id

  def delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'incidents/' + options[id]
  end
end

###
#
#
class CachetMetrics
  ##
  # List all Metrics.
  #
  # @return object

  def list
    CachetClient.request method:  :get,
                         url:     @base_url + 'metrics'
  end

  ##
  # Create Metric.
  #
  # @option name(string) **Required** Metric name
  # @option suffix(string) **Required** Measurments in
  # @option description (string) **Required** Description of what is measured
  # @option default_value(int) **Required** The default value for points
  # @option display_chart(int) Whether to display the chart on the status page
  # @return object
  # name, suffix, description, default_value, display_chart

  def create(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'metrics',
                         payload: options
  end

  ##
  # List Metric by ID Without Points.
  #
  # @option id(int) Metric id
  # @return object
  # id

  def list_id(options)
    CachetClient.request method:  :get,
                         url:     @base_url + 'metrics/' + options[id]
  end

  ##
  # Delete a Metric.
  #
  # @option id(int) Metric id
  # @return object
  # id

  def delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'metrics/' + options[id]
  end

  ##
  # List Metric Points.
  #
  # @option id(int) Metric id
  # @return object
  # id

  def point_list(options)
    CachetClient.request method:  :get,
                         url:     @base_url + 'metrics/' + options[id] + '/points'
  end

  ##
  # Add Metric Point.
  #
  # @option id(int) **Required** Metric id
  # @option value(int) **Required** Value to plot on the metric graph
  # @option timestamp(string) Unix timestamp of the point was measured
  # @return object
  # id, value, timestamp

  def point_add(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'metrics/' + options[id] + '/points',
                         payload: options
  end

  ##
  # Delete Metric Point.
  #
  # @option id(int) **Required** Metric id
  # @option point_id(int) **Required** Metric Point id
  # @return object
  # id, point_id

  def point_delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'metrics/' + options[id] + '/points/' + options[point_id],
                         payload: options
  end
end

###
#
#
class CachetSubscribers
  ##
  # List all Subscribers.
  #
  # @return object

  def list
    CachetClient.request method:  :get,
                         url:     @base_url + 'subscribers'
  end

  ##
  # Create Subscriber.
  #
  # @option email(string) **Required** Email address to subscribe
  # @option verify(int) Whether to send verification email 0/1
  # @return object
  # email, verify

  def create(options)
    CachetClient.request method:  :post,
                         url:     @base_url + 'subscribers',
                         payload: options
  end

  ##
  # Delete a Subscriber.
  #
  # @option id(int) ID of the subscriber to delete
  # @return object
  # id

  def delete(options)
    CachetClient.request method:  :delete,
                         url:     @base_url + 'subscribers/' + options[id]
  end
end
