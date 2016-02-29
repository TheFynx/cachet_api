require_relative '../lib/cachet'
require 'rspec'

# CACHETCLIENT
describe CachetClient do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }
  let(:api_headers) do
    {
      'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
      'Content-Type' => 'application/json'
    }
  end

  let(:cachetclient) { CachetClient.new api_key, base_url }

  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetclient.should be_an_instance_of CachetClient
  end

  # PING

  describe '#ping' do
    let(:response) { return cachetclient.ping }

    it 'should return a PONG' do
      response.should_not be nil
      response['data'].should eq 'Pong!'
    end
  end
end

# COMPONENTS
describe CachetComponents do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }
  let(:api_headers) do
    {
      'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
      'Content-Type' => 'application/json'
    }
  end
  ## Create new componet client
  let(:cachetcomponents) { CachetComponents.new api_key, base_url }
  ## Create mock component to test
  let(:mock_components) do
    {
      'id'            => 1,
      'name'          => 'API_test',
      'description'   => 'Used by cachet_api gem for testing',
      'link'          => 'http://justtesting.domain.com',
      'status'        => 1,
      'order'         => 0,
      'group_id'      => 0,
      'created_at'    => '2016-02-25 02:30:02',
      'updated_at'    => '2016-02-25 02:30:02',
      'deleted_at'    => 'null',
      'enabled'       => 'true',
      'status_name'   => 'Operational'
    }
  end
  ## Test CachetComponents.list
  describe '#CachetComponents.list' do
    let(:response) { return cachetcomponents.list }

    it 'return component list should return anything legit' do
      response.should_not be nil
      response['data'][0]['id'].should_not be nil
    end
  end

  ## Test CachetComponents.list_id
  describe '#CachetComponents.list_id' do
    let(:options) do
      {
        'id' => mock_components['id']
      }
    end
    let(:components_list_id_response) { cachetcomponents.list_id options }

    it 'should return single component and match mock component' do
      components_list_id_response['data']['id'].should eq mock_components['id']
    end
  end

  # ## Test CachetComponents.create
  # describe '#CachetComponents.create' do
  #   let(:options) do
  #     {
  #       'name'      => mock_components['name'],
  #       'status'    => CachetClient::STATUS_OPERATIONAL,
  #       'link'      => mock_components['link'],
  #       'order'     => mock_components['order'],
  #       'group_id'  => mock_components['group_id'],
  #       'enabled'   => mock_components['enabled']
  #     }
  #   end
  #   let(:components_create_response) { cachetcomponents.create options }
  #
  #   it 'should create single component and match mock component' do
  #     components_create_response['data']['name'].should eq mock_components['name']
  #     components_create_response['data']['status'].should eq CachetClient::STATUS_OPERATIONAL
  #     components_create_response['data']['link'].should eq mock_components['link']
  #     components_create_response['data']['order'].should eq 0
  #     components_create_response['data']['group_id'].should eq 0
  #     components_create_response['data']['enabled'].should eq true
  #   end
  # end
  #
  # ## Test CachetComponents.update
  # describe '#CachetComponents.update' do
  #   let(:options) do
  #     {
  #       'id' => mock_components['id'],
  #       'name' => 'API',
  #       'status' => CachetClient::STATUS_OPERATIONAL
  #     }
  #   end
  #   let(:components_update_response) { cachetcomponents.update options }
  #
  #   it 'should update single component and response should match updated component items' do
  #     components_update_response['data']['id'].should eq mock_components['id']
  #     components_update_response['data']['name'].should eq 'API'
  #     components_update_response['data']['status'].should eq CachetClient::STATUS_OPERATIONAL
  #   end
  # end
end

# INCIDENTS
describe CachetIncidents do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }
  let(:api_headers) do
    {
      'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
      'Content-Type' => 'application/json'
    }
  end
  ## Create new incident client
  let(:cachetincidents) { CachetIncidents.new api_key, base_url }
  ## Create mock incident to test
  let(:mock_incidents) do
    {
      'id'            => 1,
      'component_id'  => 0,
      'name'          => 'Awesome',
      'status'        => 4,
      'message'       => ':+1: We totally nailed the fix.',
      'created_at'    => '2016-02-26 14:30:01',
      'updated_at'    => '2016-02-26 14:30:01',
      'deleted_at'    => 'null',
      'scheduled_at'  => '2016-02-26 15:06:31',
      'visible'       => 1,
      'human_status'  => 'Fixed'
    }
  end
  ## Test CachetIncidents.list
  describe '#CachetIncidents.list' do
    let(:response) { return cachetincidents.list }

    it 'mock incident should match length of demo incident' do
      response.should_not be nil
      response['data'][0]['id'].should_not be nil
    end

  end

  ## Test CachetIncidents.list_id
  describe '#CachetIncidents.list_id' do
    let(:options) do
      {
        'id' => '1'
      }
    end
    let(:components_list_id_response) { cachetincidents.list_id options }

    it 'should return single incident and match mock incident' do
      components_list_id_response['data']['id'].should eq mock_incidents['id']
    end
  end

  # ## Test CachetIncidents.create
  # describe '#CachetIncidents.create' do
  #   let(:options) do
  #     {
  #       'name'              => 'cachet_api Incident Test!',
  #       'message'           => 'cachet_api gem testing',
  #       'status'            => CachetClient::INCIDENT_INVESTIGATING,
  #       'visible'           => mock_incidents['visible'],
  #       'component_id'      => mock_incidents['component_id'],
  #       'component_status'  => mock_incidents['component_status'],
  #       'notify'            => false
  #     }
  #   end
  #   let(:components_create_response) { cachetincidents.create options }
  #
  #   it 'should create single component and match mock component' do
  #     components_create_response['data']['name'].should eq 'cachet_api Incident Test!'
  #     components_create_response['data']['message'].should eq 'cachet_api gem testing'
  #     components_create_response['data']['status'].should eq CachetClient::INCIDENT_INVESTIGATING
  #     components_create_response['data']['visible'].should eq mock_incidents['visible']
  #     components_create_response['data']['order'].should eq mock_incidents['order']
  #     components_create_response['data']['component_id'].should eq mock_incidents['component_id']
  #     components_create_response['data']['component_status'].should eq mock_incidents['component_status']
  #     components_create_response['data']['notify'].should eq false
  #   end
  # end
  #
  # ## Test CachetIncidents.update
  # describe '#CachetIncidents.update' do
  #   let(:options) do
  #     {
  #       'id' => mock_incidents['id'],
  #       'name' => mock_incidents['name'],
  #       'status' => CachetClient::INCIDENT_WATCHING
  #     }
  #   end
  #   let(:components_update_response) { cachetincidents.update options }
  #
  #   it 'should update single component and response should match updated component items' do
  #     components_update_response['data']['id'].should eq mock_incidents['id']
  #     components_update_response['data']['name'].should eq mock_incidents['name']
  #     components_update_response['data']['status'].should eq CachetClient::INCIDENT_WATCHING
  #   end
  # end
end

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
      'component_id'  => 0,
      'name'          => 'Awesome',
      'status'        => 4,
      'message'       => ':+1: We totally nailed the fix.',
      'created_at'    => '2016-02-26 14:30:01',
      'updated_at'    => '2016-02-26 14:30:01',
      'deleted_at'    => 'null',
      'scheduled_at'  => '2016-02-26 15:06:31',
      'visible'       => 1,
      'human_status'  => 'Fixed'
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

# METRICS
describe CachetSubscribers do
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
      'component_id'  => 0,
      'name'          => 'Awesome',
      'status'        => 4,
      'message'       => ':+1: We totally nailed the fix.',
      'created_at'    => '2016-02-26 14:30:01',
      'updated_at'    => '2016-02-26 14:30:01',
      'deleted_at'    => 'null',
      'scheduled_at'  => '2016-02-26 15:06:31',
      'visible'       => 1,
      'human_status'  => 'Fixed'
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
