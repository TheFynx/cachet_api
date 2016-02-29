require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Subscribers
describe CachetSubscribers do
  let(:api_key) { '9yMHsdioQosnyVK4iCVR' }
  let(:base_url) { 'https://demo.cachethq.io/api/v1/' }

  ## Create new componet client
  let(:cachetsubscribers) { CachetSubscribers.new api_key, base_url }
  it 'should success' do
    api_key.should eq '9yMHsdioQosnyVK4iCVR'
    cachetsubscribers.should be_an_instance_of CachetSubscribers
  end

  describe 'CachetSubscribers' do
    ## Test CachetSubscribers.create
    let(:random_email) { 'test' + SecureRandom.urlsafe_base64 + '@testing.com' }
    let(:options_subscribe_create) do
      {
        'email' => random_email,
        'verify' => '0'
      }
    end
    let(:subscribers_create_response) { cachetsubscribers.create(options_subscribe_create) }
    it 'should return created subscriber with id' do
      subscribers_create_response.should_not be nil
      subscribers_create_response['data']['id'].should_not be nil
    end

    ## Test CachetSubscribers.list
    let(:subscribers_list_response) { return cachetsubscribers.list }
    it 'return subscriber list, assign to variable, and variable should return data' do
      subscribers_list_response.should_not be nil
      subscribers_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetSubscribers.delete
    let(:options_subscribe_delete) do
      {
        'id' => subscribers_list_response['data'][0]['id']
      }
    end
    let(:subscribers_delete_response) { cachetsubscribers.delete options_subscribe_delete }
    it 'should delete previously created subscriber and return a 204' do
      subscribers_delete_response['data'].should eq 204
    end
  end
end
