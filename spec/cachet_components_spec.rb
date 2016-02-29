require_relative '../lib/cachet'
require 'rspec'

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
