require_relative '../lib/cachet'
require 'rspec'

# METRICS
describe CachetMetrics do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }
  let(:api_headers) do
    {
      'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
      'Content-Type' => 'application/json'
    }
  end
  ## Create new incident client
  let(:cachetmetrics) { CachetMetrics.new api_key, base_url }
  ## Create mock incident to test
  let(:mock_metrics) do
    {
      'id'            => 1,
      'name'          => 'Cups of coffee',
      'suffix'        => 'Cups',
      'description'   => "How many cups of coffee we've drank.",
      'default_value' => 0,
      'calc_type'     => 1,
      'display_chart' => 'true',
      'created_at'    => '2016-02-29 16:30:01',
      'updated_at'    => '2016-02-29 16:30:01',
      'places'        => 2,
      'default_view'  => 1
    }
  end
  ## Test CachetMetrics.list
  describe '#CachetMetrics.list' do
    let(:response) { return cachetmetrics.list }

    it 'should succesfully pull metric list' do
      response.should_not be nil
      response['data'][0]['id'].should_not be nil
    end
  end
end
