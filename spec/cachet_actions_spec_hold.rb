require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Actions
describe CachetActions do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new componet client
  Actions = CachetActions.new(api_key, base_url)

  describe 'CachetActions' do
    ## Test CachetActions.create
    options_action_create = {}
    options_action_create['name'] = 'ActionTest-' + SecureRandom.hex(5)
    options_action_create['description'] = 'Test Action for cachet_api gem'
    options_action_create['active'] = 'true'
    options_action_create['start_at'] = '2017-09-01 00:00:00'
    options_action_create['timezone'] = 'Europe/London'
    options_action_create['window_length'] = '86400'
    options_action_create['completion_latency'] = '10800'
    actions_create_response = Actions.create(options_action_create)
    it 'should return created action with id' do
      actions_create_response.should_not be nil
      actions_create_response['data']['id'].should_not be nil
      actions_create_response['data']['name'].should eq options_action_create['name']
    end

    ## Test CachetActions.list
    actions_list_response = Actions.list
    it 'return action list, assign to variable, and variable should return data' do
      actions_list_response.should_not be nil
      actions_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetActions.list_id
    options_action_list_id = {}
    options_action_list_id['id'] = actions_create_response['data']['id']
    actions_list_id_response = Actions.list_id(options_action_list_id)
    it 'return action list by id and variable match data to created action' do
      actions_list_id_response.should_not be nil
      actions_list_id_response['data']['id'].should eq actions_create_response['data']['id']
      actions_list_id_response['data']['name'].should eq options_action_create['name']
    end
    ## Test CachetActions.instance_create
    options_action_instance_add = {}
    options_action_instance_add['action'] = actions_create_response['data']['id']
    options_action_instance_add['description'] = 'Test instance for cachet_api'
    options_action_instance_add['active'] = 'false'
    actions_instance_add_response = Actions.instance_add(options_action_instance_add)
    it 'add action instance and validate id and action_id' do
      actions_instance_add_response.should_not be nil
      actions_instance_add_response['data']['id'].should_not be nil
      actions_instance_add_response['data']['action_id'].should eq actions_create_response['data']['id']
    end

    ## Test CachetActions.instance_list
    options_action_instance_list = {}
    options_action_instance_list['id'] = actions_create_response['data']['id']
    actions_instance_list_response = Actions.instance_list(options_action_instance_list)
    it 'return list of action instances for create action' do
      actions_instance_list_response.should_not be nil
      actions_instance_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetActions.delete
    options_action_delete = {}
    options_action_delete['id'] = actions_create_response['data']['id']
    actions_delete_response = Actions.delete(options_action_delete)
    it 'should delete previously created action and return a 204' do
      actions_delete_response['data'].should eq 204
    end
  end
end
