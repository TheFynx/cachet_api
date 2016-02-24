require_relative '../lib/cachet'
require 'rspec'
require 'httparty'

describe CachetClient do
	let (:api_key) { '9yMHsdioQosnyVK4iCVR' }
	let (:base_url) { 'https://demo.cachethq.io/api/v1/' }
	let (:api_headers) {
		{
			'X-Cachet-Token' => '9yMHsdioQosnyVK4iCVR',
			'Content-Type' => 'application/json'
		}
	}

	let (:cachetclient) { CachetClient.new api_key, base_url }
	let (:mock_components) {
		[{
			 'id' => '1',
			 'status' => '1',
		 }]
	}

	it 'should success' do
		api_key.should eq '9yMHsdioQosnyVK4iCVR'
		cachetclient.should be_an_instance_of CachetClient
	end

	#   COMPONENT
	describe 'Testing components methods' do
		describe '#component_list' do
			let (:response) { return cachetclient.component_list }

			it 'should not never an error return, the message should be ok' do
				response.should_not be nil
				response['status']['error'].should eq 'no'
				response['status']['message'].should eq 'OK'

				response['result'].length.should eq mock_components.length
				response['result'].each_with_index do |component, key|
					component['containers'].length.should eq mock_components[key]['containers'].length
				end
			end

			it 'should be equal with the actual result that get with httparty' do
				actual_response = HTTParty.get(base_url + 'components/', :headers => api_headers)
				actual_response.code.should eq 200

				response.should eq JSON.parse(actual_response.body)
			end
		end

		# Test component_status_update
		describe '#component_status_update' do
			let (:components) { [mock_components[0]] }
			let (:containers) { [components[0]['containers'][0]] }
			let (:component_status_update_response) {
				cachetclient.component_status_update id,
				                                       [components[0]['_id']],
				                                       '#Test updating component',
				                                       CachetClient::STATUS_OPERATIONAL
			}

			it 'should update single component and return with "result" equal true with the message' do

				component_status_update_response['status']['error'].should eq 'no'
				component_status_update_response['status']['message'].should eq 'OK'
				component_status_update_response['result'].should eq true

			end
		end
	end
end
