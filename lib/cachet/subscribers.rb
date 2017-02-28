# frozen_string_literal: true

###
# Inherits CachetClient and handles all Subscribers API Calls
#
class CachetSubscribers < CachetClient
  def initialize
    super()
  end
  
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
            url:     @base_url + 'subscribers/' + options['id'].to_s
  end
end
