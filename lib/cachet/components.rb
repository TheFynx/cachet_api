# frozen_string_literal: true

###
# Inherits CachetClient and handles all Components API Calls
#
class CachetComponents < CachetClient
  ##
  # List all Components.
  #
  # @return object

  def list(options = nil)
    request method:  :get,
            url:     @base_url + 'components',
            headers: {params: options}
  end

  ##
  # List Component by ID.
  # @option options [string] :id Numeric component id
  # @return object

  def list_id(options)
    request method:  :get,
            url:     @base_url + 'components/' + options['id'].to_s
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
            url:     @base_url + 'components/' + options['id'].to_s,
            payload: options
  end

  ##
  # Delete Component.
  #
  # @option options [string] :id **Required** Numeric component id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'components/' + options['id'].to_s
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
            url:     @base_url + 'components/groups/' + options['id'].to_s
  end

  ##
  # Create Component Group.
  #
  # @option options [string] :name **Required** Component group name
  # @option options [int] :order Numeric order of the component group
  # @option options [int] :collapsed Whether to collapse the group by default
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
            url:     @base_url + 'components/groups/' + options['id'].to_s,
            payload: options
  end

  ##
  # Delete Component Group.
  #
  # @option options [string] :id **Required** Numeric component group id
  # @return object

  def groups_delete(options)
    request method:  :delete,
            url:     @base_url + 'components/groups/' + options['id'].to_s
  end
end
