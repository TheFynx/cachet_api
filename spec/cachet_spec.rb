require_relative '../lib/cachet'
require 'rspec'
require 'httparty'

describe CachetClient do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }
  let(:api_headers) {
    {
      'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
      'Content-Type' => 'application/json'
    }
  }

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

  # COMPONENT
  describe 'Testing components methods' do
    let(:cachetcomponents) { CachetComponents.new api_key, base_url }
    let(:mock_components) {
      [{
          'id'            => '1',
          'name'          => 'API',
          'description'   => 'Used by third-parties to connect to us',
          'link'          => '',
          'status'        => '1',
          'order'         => '0',
          'group_id'      => '0',
          'created_at'    => '2016-02-25 02:30:02',
          'updated_at'    => '2016-02-25 02:30:02',
          'deleted_at'    => 'null',
          'enabled'       => 'true',
          'status_name'   => 'Operational'
      }]
    }
    describe '#components_list' do
      let(:response) { return cachetcomponents.list }

      it 'mock component should match length of demo component' do
        response.should_not be nil

        response['data'][0].length.should eq mock_components[0].length
      end

      it 'should be equal with the actual result that get with httparty' do
        actual_response = HTTParty.get(base_url + 'components/', headers: api_headers)
        actual_response.code.should eq 200
        response.should eq JSON.parse(actual_response.body)
      end
    end

    # Test components_update
    describe '#components_update' do
      let(:components) { [mock_components[0]] }
      let(:options) do
        {
          :id => [components[0]['id']],
          :name => [components[0]['name']],
          :status => CachetClient::STATUS_OPERATIONAL
        }
      end
      let(:components_update_response) {cachetcomponents.update options}

      it 'should update single component and return with "result" equal true with the message' do
        components_update_response.code.should eq 200
        components_update_response['data']['id'].should eq [options['id']]
      end
    end
  end
end
