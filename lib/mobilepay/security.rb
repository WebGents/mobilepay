require 'json'
require_relative 'security/public_key'
require_relative 'requests'
require_relative 'requests/generate_signature'

module Mobilepay
    class Security
        include Mobilepay::Security::PublicKey
        include Mobilepay::Requests
        include Mobilepay::Requests::GenerateSignature

        attr_reader :subscription_key, :privatekey, :test_mode, :base_uri

        def initialize(args = {})
            @subscription_key = args[:subscription_key] || ''
            @privatekey = nil
            @test_mode = false
            @base_uri = 'https://api.mobeco.dk/merchantsecurity/api'
        end

        private

        def call
            response = http_request(:get, '/publickey')
            check_response(response)
            response
        end

        def check_response(response)
            if response.code != '200'
                error_message = response.body.empty? ? response.code : JSON.parse(response.body)['message']
                raise Failure, error_message
            end
        end
    end
end