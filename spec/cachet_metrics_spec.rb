require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Metrics
describe CachetMetrics do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new componet client
  CachetMetrics = CachetMetrics.new(api_key, base_url)

  describe 'CachetMetrics' do
    ## Test CachetMetrics.create
    options_metric_create = {}
    options_metric_create['name'] = 'MetricTest-' + SecureRandom.hex(5)
    options_metric_create['suffix'] = 'ms'
    options_metric_create['description'] = 'Test Metric for cachet_api gem'
    options_metric_create['default_value'] = '0'
    options_metric_create['display_chart'] = '0'
    metrics_create_response = CachetMetrics.create(options_metric_create)
    it 'should return created metric with id' do
      metrics_create_response.should_not be nil
      metrics_create_response['data']['id'].should_not be nil
      metrics_create_response['data']['name'].should eq options_metric_create['name']
    end

    ## Test CachetMetrics.list
    metrics_list_response = CachetMetrics.list
    it 'return metric list, assign to variable, and variable should return data' do
      metrics_list_response.should_not be nil
      metrics_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetMetrics.list_id
    options_metric_list_id = {}
    options_metric_list_id['id'] = metrics_create_response['data']['id']
    metrics_list_id_response = CachetMetrics.list_id(options_metric_list_id)
    it 'return metric list by id and variable match data to created metric' do
      metrics_list_id_response.should_not be nil
      metrics_list_id_response['data']['id'].should eq metrics_create_response['data']['id']
      metrics_list_id_response['data']['name'].should eq options_metric_create['name']
    end
    ## Test CachetMetrics.point_add
    options_metric_point_add = {}
    options_metric_point_add['id'] = metrics_create_response['data']['id']
    options_metric_point_add['value'] = '1'
    metrics_point_add_response = CachetMetrics.point_add(options_metric_point_add)
    it 'add metric point and validate id and metric_id' do
      metrics_point_add_response.should_not be nil
      metrics_point_add_response['data']['id'].should_not be nil
      metrics_point_add_response['data']['metric_id'].should eq metrics_create_response['data']['id']
    end

    ## Test CachetMetrics.point_list
    options_metric_point_list = {}
    options_metric_point_list['id'] = metrics_create_response['data']['id']
    metrics_point_list_response = CachetMetrics.point_list(options_metric_point_list)
    it 'return list of metric points for create metric' do
      metrics_point_list_response.should_not be nil
      metrics_point_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetMetrics.point_delete
    options_metric_point_delete = {}
    options_metric_point_delete['id'] = metrics_create_response['data']['id']
    options_metric_point_delete['point_id'] = metrics_point_add_response['data']['id']
    metrics_point_delete_response = CachetMetrics.point_delete(options_metric_point_delete)
    it 'should delete previously created metric point and return a 204' do
      metrics_point_delete_response['data'].should eq 204
    end

    ## Test CachetMetrics.delete
    options_metric_delete = {}
    options_metric_delete['id'] = metrics_create_response['data']['id']
    metrics_delete_response = CachetMetrics.delete(options_metric_delete)
    it 'should delete previously created metric and return a 204' do
      metrics_delete_response['data'].should eq 204
    end
  end
end
