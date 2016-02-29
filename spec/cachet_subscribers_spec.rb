require_relative '../lib/cachet'
require 'rspec'
require 'securerandom'

# Subscribers
describe CachetSubscribers do
  api_key = '9yMHsdioQosnyVK4iCVR'
  base_url = 'https://demo.cachethq.io/api/v1/'

  ## Create new componet client
  CachetSubscribers = CachetSubscribers.new(api_key, base_url)

  describe 'CachetSubscribers' do
    ## Test CachetSubscribers.create
    random_email = 'test' + SecureRandom.urlsafe_base64 + '@testing.com'
    options_subscribe_create = {}
    options_subscribe_create['email'] = random_email
    options_subscribe_create['verify'] = '0'
    subscribers_create_response = CachetSubscribers.create(options_subscribe_create)
    it 'should return created subscriber with id' do
      subscribers_create_response.should_not be nil
      subscribers_create_response['data']['id'].should_not be nil
    end

    ## Test CachetSubscribers.list
    subscribers_list_response = CachetSubscribers.list
    it 'return subscriber list, assign to variable, and variable should return data' do
      subscribers_list_response.should_not be nil
      subscribers_list_response['data'][0]['id'].should_not be nil
    end

    ## Test CachetSubscribers.delete
    options_subscribe_delete = {}
    options_subscribe_delete['id'] = subscribers_create_response['data']['id']
    subscribers_delete_response = CachetSubscribers.delete(options_subscribe_delete)
    it 'should delete previously created subscriber and return a 204' do
      subscribers_delete_response['data'].should eq 204
    end
  end
end
