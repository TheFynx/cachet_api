require_relative '../lib/cachet'
require 'rspec'

# Subscribers
describe CachetSubscribers do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

  ## Create new incident client
  let(:cachetsubscribers) { CachetSubscribers.new api_key, base_url }
  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetsubscribers.should be_an_instance_of CachetSubscribers
  end
  ## Create mock incident to test
  let(:mock_subscribers) do
    {
      'id'            => 1,
      'email'         => 'test@testing.com',
      'verify_code'   => 'Cw8AqAzulLonity44tv2Ah88x9HgWQA2lgE84p0k3B',
      'verified_at'   => '2016-02-29 16:46:26',
      'created_at'    => '2016-02-29 16:46:19',
      'updated_at'    => '2016-02-29 16:46:19',
      'subscriptions' => []
    }
  end
  ## Test CachetSubscribers.list
  describe '#CachetSubscribers.list' do
    let(:response) { return cachetsubscribers.list }

    it 'should succesfully pull metric list' do
      response.should_not be nil
      response['data'][0]['id'].should_not be nil
    end
  end
end
