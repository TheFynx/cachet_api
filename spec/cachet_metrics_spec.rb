require_relative '../lib/cachet'
require 'rspec'

# METRICS
describe CachetMetrics do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

  ## Create new componet client
  let(:cachetmetrics) { CachetMetrics.new api_key, base_url }
  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetmetrics.should be_an_instance_of CachetMetrics
  end
  describe 'CachetMetrics' do
    ## Test CachetMetrics.list
    let(:metrics_list_response) { return cachetmetrics.list }
    let(:testmetric) { metrics_list_response['data'][0] }
    it 'return metric list, assign to variable, and variable should return data' do
      testmetric.should_not be nil
      testmetric['id'].should_not be nil
    end

    ## Test CachetMetrics.list_id
    let(:options_list) do
      {
        'id' => testmetric['id']
      }
    end
    let(:metrics_list_id_response) { cachetmetrics.list_id options_list }
    it 'should return single metric and match metric pulled earlier' do
      metrics_list_id_response['data']['id'].should eq testmetric['id']
    end
  end
end
