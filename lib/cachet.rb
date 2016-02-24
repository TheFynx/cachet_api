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
            :url     => @base_url + '/ping'
  end

  ##
  # List all components.
  #
  # @return object

  def component_list
    request :method  => :get,
            :url     => @base_url + 'components/'
  end

  ##
  # List specific component by id.
  #
  # @param id(int) Numeric component id
  # @return object

  def component_list_id(id)
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

  def component_create(name, description, status, link, order, group_id, enabled)
    request :method  => :post,
            :url     => @base_url + 'components/'
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

  def component_update(id, name, status, link, order, group_id)
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
  # Delete component by ID.
  #
  # @param id(int) **Required** Numeric component id
  # @return object

  def component_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'components/' + id
  end

  ##
  # List all component groups.
  #
  # @return object

  def component_group_list
    request :method  => :get,
            :url     => @base_url + 'components/groups/'
  end

  ##
  # List specific component group by id.
  #
  # @param id(int) **Required** Numeric component group id
  # @return object

  def component_group_list_id(id)
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

  def component_group_create(name, order, collapsed)
    request :method  => :post,
            :url     => @base_url + 'components/groups/'
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

  def component_group_update(id, name, order, collapsed)
    request :method  => :put,
            :url     => @base_url + 'components/groups/'
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

  def component_group_delete(id)
    request :method  => :delete,
            :url     => @base_url + 'components/groups/' + id
  end
