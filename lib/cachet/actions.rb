# frozen_string_literal: true

###
# Inherits CachetClient and handles all Actions API Calls
#
class CachetActions < CachetClient
  ##
  # List all Actions.
  #
  # @return object

  def list
    request method:  :get,
            url:     @base_url + 'actions'
  end

  ##
  # Create Action.
  #
  # @option options [string] :name **Required** The name of the action
  # @option options [string] :description  A description of what the action does
  # @option options [boolean] :active **Required** Whether the action is active
  # @option options [date] :start_at **Required** Start action at
  # @option options [string] :timezone **Required** The timezone this action runs in
  # @option options [int] :window_length **Required** The number of seconds between each instance running
  # @option options [int] :completion_latency **Required** The number of seconds this job has to complete
  # @option options [int] :timed_action_group_id The group id to put the action under
  # @return object

  def create(options)
    request method:  :post,
            url:     @base_url + 'actions',
            payload: options
  end

  ##
  # List Action by ID.
  #
  # @option options [int] :action **Required** Action ID
  # @return object

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'actions/' + options['action'].to_s
  end

  ##
  # Delete a Action.
  #
  # @option options [int] :action **Required** Action ID
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'actions/' + options['action'].to_s
  end

  ##
  # Delete a Action.
  #
  # @option options [int] :action **Required** Action ID
  # @option options [string] :name The name of the action
  # @option options [string] :description  A description of what the action does
  # @option options [boolean] :active Whether the action is active
  # @option options [int] :timed_action_group_id The group id to put the action under
  # @return object

  def update(options)
    request method:  :put,
            url:     @base_url + 'actions/' + options['action'].to_s,
            payload: options
  end

  ##
  # List Action Instances.
  #
  # @option options [int] :action **Required** Action ID
  # @return object

  def instance_list(options)
    request method:  :get,
            url:     @base_url + 'actions/' + options['action'].to_s + '/instances'
  end

  ##
  # Create Action Instance.
  #
  # @option options [int] :action **Required** Action ID
  # @option options [string] :message An optional message to add to the instance
  # @option options [date] :action **Required** The time in which the action instance was started
  # @option options [date] :action **Required** The time of which the action instance was completed
  # @return object

  def instance_list(options)
    request method:  :post,
            url:     @base_url + 'actions/' + options['action'].to_s + '/instances',
            payload: options
  end
end
