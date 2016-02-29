require_relative '../lib/cachet'
require 'rspec'

# COMPONENTS
describe CachetComponents do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

  ## Create new componet client
  let(:cachetcomponents) { CachetComponents.new api_key, base_url }
  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetcomponents.should be_an_instance_of CachetComponents
  end
  describe 'CachetComponents' do
    ## Test CachetComponents.list
    let(:components_list_response) { return cachetcomponents.list }
    let(:testcomponent) { components_list_response['data'][0] }
    it 'return component list, assign to variable, and variable should return data' do
      testcomponent.should_not be nil
      testcomponent['id'].should_not be nil
    end

    ## Test CachetComponents.list_id
    let(:options_list) do
      {
        'id' => testcomponent['id']
      }
    end
    let(:components_list_id_response) { cachetcomponents.list_id options_list }
    it 'should return single component and match component pulled earlier' do
      components_list_id_response['data']['id'].should eq testcomponent['id']
    end
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
