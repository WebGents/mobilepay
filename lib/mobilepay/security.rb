require 'json'
require_relative 'security/public_key'
require_relative 'requests'

module Mobilepay
    class Security
        include Mobilepay::Security::PublicKey
        include Mobilepay::Requests

        class SecurityFailure < StandardError; end

        attr_reader :subscription_key, :base_uri

        def initialize(args = {})
            @subscription_key = args[:subscription_key] || ''
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
                raise SecurityFailure, error_message
            end
        end
    end
end