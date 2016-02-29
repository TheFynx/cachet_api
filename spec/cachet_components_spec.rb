require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Components
describe CachetComponents do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new components client
  CachetComponents = CachetComponents.new(api_key, base_url)

  describe '#CachetComponents' do
    ## Test CachetComponents.create
    options_component_create = {}
    options_component_create['name'] = 'ComponentTest-' + SecureRandom.hex(5)
    options_component_create['status'] = CachetClient::STATUS_OPERATIONAL
    components_create_response = CachetComponents.create(options_component_create)
    it 'should return created component with id' do
      components_create_response.should_not be nil
      components_create_response['data']['id'].should_not be nil
      components_create_response['data']['name'].should eq options_component_create['name']
      components_create_response['data']['status'].should eq CachetClient::STATUS_OPERATIONAL
    end

    ## Test CachetComponents.list
    components_list_response = CachetComponents.list
    it 'return component list, assign to variable, and variable should return data' do
      components_list_response.should_not be nil
      components_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetComponents.list_id
    options_component_list_id = {}
    options_component_list_id['id'] = components_create_response['data']['id']
    components_list_id_response = CachetComponents.list_id(options_component_list_id)
    it 'return component list by id and variable match data to specific component' do
      components_list_id_response.should_not be nil
      components_list_id_response['data']['id'].should eq components_create_response['data']['id']
      components_list_id_response['data']['name'].should eq options_component_create['name']
    end

    # ## Test CachetComponents.groups_create
    # options_component_groups_create = {}
    # options_component_groups_create['name'] = 'ComponentGroupTest-' + SecureRandom.hex(5)
    # options_component_groups_create['order'] = 2
    # options_component_groups_create['collapsed'] = true
    # components_groups_create_response = CachetComponents.groups_create(options_component_groups_create)
    # it 'should return created component group with id' do
    #   components_groups_create_response.should_not be nil
    #   components_groups_create_response['data']['id'].should_not be nil
    #   components_groups_create_response['data']['name'].should eq options_component_groups_create['name']
    #   components_groups_create_response['data']['collapsed'].should eq options_component_groups_create['collapsed']
    # end

    ## Test CachetComponents.groups_list
    components_groups_list_response = CachetComponents.groups_list
    it 'return component group list, assign to variable, and variable should return data' do
      components_groups_list_response.should_not be nil
      components_groups_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetComponents.groups_list_id
    options_component_list_id = {}
    options_component_list_id['id'] = components_groups_list_response['data'][0]['id']
    components_groups_list_id_response = CachetComponents.groups_list_id(options_component_list_id)
    it 'return component group list by id and variable match data to specific component group' do
      components_groups_list_id_response.should_not be nil
      components_groups_list_id_response['data']['id'].should eq components_groups_list_response['data'][0]['id']
      components_groups_list_id_response['data']['name'].should eq components_groups_list_response['data'][0]['name']
    end

    ## Test CachetComponents.update
    options_component_update = {}
    options_component_update['id'] = components_create_response['data']['id']
    options_component_update['name'] = components_create_response['data']['name']
    options_component_update['status'] = CachetClient::STATUS_PARTIAL_OUTAGE
    # options_component_update['group_id'] = components_groups_create_response['data']['id']
    components_update_response = CachetComponents.update(options_component_update)
    it 'should return updated component with id and updated status' do
      components_update_response.should_not be nil
      components_update_response['data']['id'].should_not be nil
      components_update_response['data']['name'].should eq components_create_response['data']['name']
      components_update_response['data']['status'].should eq CachetClient::STATUS_PARTIAL_OUTAGE
      # components_update_response['data']['group_id'].should eq components_groups_create_response['data']['id']
    end

    # ## Test CachetComponents.groups_update
    # options_component_groups_update = {}
    # options_component_groups_update['id'] = components_groups_create_response['data']['id']
    # options_component_groups_update['name'] = components_groups_create_response['data']['name']
    # options_component_groups_update['order'] = '1'
    # components_groups_update_response = CachetComponents.groups_update(options_component_groups_update)
    # it 'should update and return updates for created component group with id' do
    #   components_groups_update_response.should_not be nil
    #   components_groups_update_response['data']['id'].should_not be nil
    #   components_groups_update_response['data']['name'].should eq components_groups_create_response['data']['name']
    #   components_groups_update_response['data']['order'].should eq options_component_groups_update['order']
    # end

    ## Test CachetComponents.delete
    options_components_delete = {}
    options_components_delete['id'] = components_create_response['data']['id']
    components_delete_response = CachetComponents.delete(options_components_delete)
    it 'should delete previously created groups and return a 204' do
      components_delete_response['data'].should eq 204
    end

    # ## Test CachetComponents.groups_delete
    # options_components_groups_delete = {}
    # options_components_groups_delete['id'] = components_groups_create_response['data']['id']
    # components_groups_delete_response = CachetComponents.groups_delete(options_components_groups_delete)
    # it 'should delete previously created groups and return a 204' do
    #   components_groups_delete_response['data'].should eq 204
    # end
  end
end
