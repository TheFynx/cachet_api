# frozen_string_literal: true

###
# Inherits CachetClient and handles all Metrics API Calls
#
class CachetMetrics < CachetClient
  def initialize
    super()
  end
  
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
  # @option options [int] :display_chart **Required** Whether to display the chart on the status page
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
            url:     @base_url + 'metrics/' + options['id'].to_s
  end

  ##
  # Delete a Metric.
  #
  # @option options [string] :id Numeric Metric id
  # @return object

  def delete(options)
    request method:  :delete,
            url:     @base_url + 'metrics/' + options['id'].to_s
  end

  ##
  # List Metric Points.
  #
  # @option options [string] :id Numeric Metric id
  # @return object

  def point_list(options)
    request method:  :get,
            url:     @base_url + 'metrics/' + options['id'].to_s + '/points'
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
            url:     @base_url + 'metrics/' + options['id'].to_s + '/points',
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
            url:     @base_url + 'metrics/' + options['id'].to_s + '/points/' + options['point_id'].to_s,
            payload: options
  end
end
