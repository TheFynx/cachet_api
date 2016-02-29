require_relative '../lib/cachet'
require 'rspec'

# CACHETCLIENT
describe CachetClient do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

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
