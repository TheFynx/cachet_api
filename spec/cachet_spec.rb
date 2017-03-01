require_relative '../lib/cachet'
require 'rspec'

# Client
describe CachetClient do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new subscribers client
  Client = CachetClient.new(api_key, base_url)

  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
  end

  # PING
  describe '#ping' do
    response = Client.ping

    it 'should return a PONG' do
      response.should_not be nil
      response['data'].should eq 'Pong!'
    end
  end
end
