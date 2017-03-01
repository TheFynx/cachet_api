# frozen_string_literal: true

###
# Inherits CachetClient and handles all Incidents API Calls
#
class CachetIncidents < CachetClient
  ##
  # List all Incidents.
  #
  # @return object

  def list(options = nil)
    request method:  :get,
            url:     @base_url + 'incidents',
            headers: {params: options}
  end

  ##
  # List Incident by ID.
  #
  # @option options [string] :id Numeric incident id
  # @return object

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'incidents/' + options['id'].to_s
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
            url:     @base_url + 'incidents/' + options['id'].to_s,
            payload: options
  end

  ##
  # Delete Incident.
  #
  # @option options [string] :id Numeric incident id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'incidents/' + options['id'].to_s
  end
end
