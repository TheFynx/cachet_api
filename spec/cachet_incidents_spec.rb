require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Incidents
describe CachetIncidents do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new incidents client
  CachetIncidents = CachetIncidents.new(api_key, base_url)

  describe '#CachetIncidents' do
    ## Test CachetIncidents.create
    options_incident_create = {}
    options_incident_create['name'] = 'IncidentTest-' + SecureRandom.hex(5)
    options_incident_create['message'] = 'Testing cachet_api gem'
    options_incident_create['status'] = CachetClient::INCIDENT_INVESTIGATING
    options_incident_create['visible'] = 1
    incidents_create_response = CachetIncidents.create(options_incident_create)
    it 'should return created incident with id' do
      incidents_create_response.should_not be nil
      incidents_create_response['data']['id'].should_not be nil
      incidents_create_response['data']['name'].should eq options_incident_create['name']
      incidents_create_response['data']['status'].should eq CachetClient::INCIDENT_INVESTIGATING.to_s
    end

    ## Test CachetIncidents.list
    incidents_list_response = CachetIncidents.list
    it 'return incident list, assign to variable, and variable should return data' do
      incidents_list_response.should_not be nil
      incidents_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetIncidents.list_id
    options_incident_list_id = {}
    options_incident_list_id['id'] = incidents_create_response['data']['id']
    incidents_list_id_response = CachetIncidents.list_id(options_incident_list_id)
    it 'return incident list by id and variable match data to specific incident' do
      incidents_list_id_response.should_not be nil
      incidents_list_id_response['data']['id'].should eq incidents_create_response['data']['id']
      incidents_list_id_response['data']['name'].should eq options_incident_create['name']
    end

    ## Test CachetIncidents.update
    options_incident_update = {}
    options_incident_update['id'] = incidents_create_response['data']['id']
    options_incident_update['name'] = incidents_create_response['data']['name']
    options_incident_update['message'] = 'cachet_api gem test update!'
    options_incident_update['status'] = CachetClient::INCIDENT_WATCHING
    incidents_update_response = CachetIncidents.update(options_incident_update)
    it 'should return updated incident with id and updated status' do
      incidents_update_response.should_not be nil
      incidents_update_response['data']['id'].should_not be nil
      incidents_update_response['data']['name'].should eq incidents_create_response['data']['name']
      incidents_update_response['data']['status'].should eq CachetClient::INCIDENT_WATCHING.to_s
    end

    ## Test CachetIncidents.delete
    options_incidents_delete = {}
    options_incidents_delete['id'] = incidents_create_response['data']['id']
    incidents_delete_response = CachetIncidents.delete(options_incidents_delete)
    it 'should delete previously created groups and return a 204' do
      incidents_delete_response['data'].should eq 204
    end
  end
end
