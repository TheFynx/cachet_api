require_relative '../lib/cachet'
require 'rspec'

# INCIDENTS
describe CachetIncidents do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

  ## Create new componet client
  let(:cachetincidents) { CachetIncidents.new api_key, base_url }
  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetincidents.should be_an_instance_of CachetIncidents
  end
  describe 'CachetIncidents' do
    ## Test CachetIncidents.list
    let(:incidents_list_response) { return cachetincidents.list }
    let(:testincident) { incidents_list_response['data'][0] }
    it 'return incident list, assign to variable, and variable should return data' do
      testincident.should_not be nil
      testincident['id'].should_not be nil
    end

    ## Test CachetIncidents.list_id
    let(:options_list) do
      {
        'id' => testincident['id']
      }
    end
    let(:incidents_list_id_response) { cachetincidents.list_id options_list }
    it 'should return single incident and match incident pulled earlier' do
      incidents_list_id_response['data']['id'].should eq testincident['id']
    end
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
  #       'incident_id'      => mock_incidents['incident_id'],
  #       'incident_status'  => mock_incidents['incident_status'],
  #       'notify'            => false
  #     }
  #   end
  #   let(:incidents_create_response) { cachetincidents.create options }
  #
  #   it 'should create single incident and match mock incident' do
  #     incidents_create_response['data']['name'].should eq 'cachet_api Incident Test!'
  #     incidents_create_response['data']['message'].should eq 'cachet_api gem testing'
  #     incidents_create_response['data']['status'].should eq CachetClient::INCIDENT_INVESTIGATING
  #     incidents_create_response['data']['visible'].should eq mock_incidents['visible']
  #     incidents_create_response['data']['order'].should eq mock_incidents['order']
  #     incidents_create_response['data']['incident_id'].should eq mock_incidents['incident_id']
  #     incidents_create_response['data']['incident_status'].should eq mock_incidents['incident_status']
  #     incidents_create_response['data']['notify'].should eq false
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
  #   let(:incidents_update_response) { cachetincidents.update options }
  #
  #   it 'should update single incident and response should match updated incident items' do
  #     incidents_update_response['data']['id'].should eq mock_incidents['id']
  #     incidents_update_response['data']['name'].should eq mock_incidents['name']
  #     incidents_update_response['data']['status'].should eq CachetClient::INCIDENT_WATCHING
  #   end
  # end
