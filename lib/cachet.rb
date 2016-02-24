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
    @base_url = base_url || ENV['CACHET_BASE_URL'] || 'https://demo.cachethq.io/api/v1/'
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
  # Ping.
  #
  # @return object

  def ping
    request :method  => :get,
            :url     => @base_url + 'ping'
  end

  ##
  # List all Components.
  #
  # @return object

  def components_list
    request :method  => :get,
            :url     => @base_url + 'components'
  end

  ##
  # List Component by ID.
  #
  # @param id(int) Numeric component id
  # @return object

  def components_list_id(id)
    request :method  => :get,
            :url     => @base_url + 'components/' + id
  end

  ##
  # Create Component.
  #
  # @param name(string) **Required** Component name
  # @param description (string) Description of the component
  # @param status(int) **Required** Numeric status of the component; 1-4
  # @param link(string) A hyperlink to the component
  # @param order(int) Numeric order of the component
  # @param group_id(int) Numeric group id component is within
  # @param enabled(boolean) True/False to enable/disable component
  # @return object

  def components_create(name, description, status, link, order, group_id, enabled)
    request :method  => :post,
            :url     => @base_url + 'components'
            :payload => {
              'name'        => name,
              'description' => description,
              'status'      => status,
              'link'        => link,
              'order'       => order,
              'group_id'    => group_id,
              'enabled'     => enabled
            }
  end

  ##
  # Update Component.
  #
  # @param id(int) **Required** Numeric component id
  # @param name(string) Component name
  # @param status(int) Numeric status of the component; 1-4
  # @param link(string) A hyperlink to the component
  # @param order(int) Numeric order of the component
  # @param group_id(int) Numeric group id component is within
  # @return object

  def components_update(id, name, status, link, order, group_id)
    request :method  => :put,
            :url     => @base_url + 'components/' + id
            :payload => {
              'id'       => id,
              'name'     => name,
              'status'   => status,
              'link'     => link,
              'order'    => order,
              'group_id' => group_id
            }
  end

  ##
  # Delete Component.
  #
  # @param id(int) **Required** Numeric component id
  # @return object

  def components_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'components/' + id
  end

  ##
  # List all Component Groups.
  #
  # @return object

  def components_groups_list
    request :method  => :get,
            :url     => @base_url + 'components/groups'
  end

  ##
  # List Component Group by ID.
  #
  # @param id(int) **Required** Numeric component group id
  # @return object

  def components_groups_list_id(id)
    request :method  => :get,
            :url     => @base_url + 'components/groups/' + id
  end

  ##
  # Create Component Group.
  #
  # @param name(string) **Required** Component group name
  # @param order(int) Numeric order of the component group
  # @param collapsed(boolean) True/False Whether to collapse the group by default
  # @return object

  def components_groups_create(name, order, collapsed)
    request :method  => :post,
            :url     => @base_url + 'components/groups'
            :payload => {
              'name'        => name,
              'order'       => order,
              'collapsed'   => collapsed
            }
  end

  ##
  # Update Component Group.
  #
  # @param id(int) **Required** Numeric component group id
  # @param name(string) Component group name
  # @param order(int) Numeric order of the component group
  # @param collapsed(boolean) True/False Whether to collapse the group by default
  # @return object

  def components_groups_update(id, name, order, collapsed)
    request :method  => :put,
            :url     => @base_url + 'components/groups'
            :payload => {
              'id'        => id,
              'name'        => name,
              'order'       => order,
              'collapsed'   => collapsed
            }
  end

  ##
  # Delete Component Group.
  #
  # @param id(int) **Required** Numeric component group id
  # @return object

  def components_groups_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'components/groups/' + id
  end

  ##
  # List all Incidents.
  #
  # @return object

  def incidents_list
    request :method  => :get,
            :url     => @base_url + 'incidents'
  end

  ##
  # List Incident by ID.
  #
  # @param id(int) Numeric incident id
  # @return object

  def incidents_list_id(id)
    request :method  => :get,
            :url     => @base_url + 'incidents/' + id
  end

  ##
  # Create Incident.
  #
  # @param name(string) **Required** Incident name
  # @param message (string) **Required** Description of the incident
  # @param status(int) **Required** Status of the incident; 1-4
  # @param visible(int) **Required** value whether the incident public 0/1
  # @param component_id(int) Component to update. (Required with component_status)
  # @param component_status(int) The status to update the given component with.
  # @param notify(boolean) True/False Whether to notify subscribers.
  # @return object

  def incidents_create(name, message, status, visible, component_id, component_status, notify)
    request :method  => :post,
            :url     => @base_url + 'incidents'
            :payload => {
              'name'              => name,
              'message'           => description,
              'status'            => status,
              'visible'           => link,
              'component_id'      => order,
              'component_status'  => group_id,
              'notify'            => notify
            }
  end

  ##
  # Update Incident.
  #
  # @param name(string) Incident name
  # @param message (string) Description of the incident
  # @param status(int) Status of the incident; 1-4
  # @param visible(int) value whether the incident public 0/1
  # @param component_id(int) Component to update. (Required with component_status)
  # @param component_status(int) The status to update the given component with.
  # @param notify(boolean) True/False Whether to notify subscribers.
  # @return object

  def incidents_update(name, message, status, visible, component_id, component_status, notify)
    request :method  => :put,
            :url     => @base_url + 'incidents/' + id
            :payload => {
              'name'              => name,
              'message'           => description,
              'status'            => status,
              'visible'           => link,
              'component_id'      => order,
              'component_status'  => group_id,
              'notify'            => notify
            }
  end

  ##
  # Delete Incident.
  #
  # @param id(int) **Required** Numeric incident id
  # @return object

  def incidents_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'incidents/' + id
  end

  ##
  # List all Metrics.
  #
  # @return object

  def metrics_list
    request :method  => :get,
            :url     => @base_url + 'metrics'
  end

  ##
  # Create Metric.
  #
  # @param name(string) **Required** Metric name
  # @param suffix(string) **Required** Measurments in
  # @param description (string) **Required** Description of what the metric is measuring
  # @param default_value(int) **Required** The default value to use when a point is added
  # @param display_chart(int) Whether to display the chart on the status page 0/1
  # @return object

  def metrics_create(name, suffix, description, default_value, display_chart)
    request :method  => :post,
            :url     => @base_url + 'metrics'
            :payload => {
              'name'          => name,
              'suffix'        => suffix,
              'description'   => description,
              'default_value' => default_value,
              'display_chart' => display_chart
            }
  end

  ##
  # List Metric by ID Without Points.
  #
  # @param id(int) Metric id
  # @return object

  def metrics_list_id(id)
    request :method  => :get,
            :url     => @base_url + 'metrics/' + id
  end

  ##
  # Delete a Metric.
  #
  # @param id(int) Metric id
  # @return object

  def metrics_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'metrics/' + id
  end

  ##
  # List Metric Points.
  #
  # @param id(int) Metric id
  # @return object

  def metrics_point_list(id)
    request :method  => :get,
            :url     => @base_url + 'metrics/' + id + '/points'
  end

  ##
  # Add Metric Point.
  #
  # @param id(int) **Required** Metric id
  # @param value(int) **Required** Value to plot on the metric graph
  # @param timestamp(string) Unix timestamp of the point was measured
  # @return object

  def metrics_point_add(id, value, timestamp)
    request :method  => :post,
            :url     => @base_url + 'metrics/' + id + '/points'
            :payload => {
              'id'        => id,
              'value'     => suffix,
              'timestamp' => timestamp
            }
  end

  ##
  # Delete Metric Point.
  #
  # @param id(int) **Required** Metric id
  # @param point_id(int) **Required** Metric Point id
  # @return object

  def metrics_point_delete(id, point_id)
    request :method  => :delete,
            :url     => @base_url + 'metrics/' + id + '/points/' + point_id
            :payload => {
              'id'        => id,
              'value'     => point_id
            }
  end

  ##
  # List all Subscribers.
  #
  # @return object

  def subscribers_list
    request :method  => :get,
            :url     => @base_url + 'subscribers'
  end

  ##
  # Create Subscriber.
  #
  # @param email(string) **Required** Email address to subscribe
  # @param verify(int) Whether to send verification email 0/1
  # @return object

  def subscribers_create(email, verify)
    request :method  => :post,
            :url     => @base_url + 'subscribers'
            :payload => {
              'email'   => email,
              'verify'  => verify
            }
  end

  ##
  # Delete a Subscriber.
  #
  # @param id(int) ID of the subscriber to delete
  # @return object

  def subscribers_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'subscribers/' + id
  end
end
