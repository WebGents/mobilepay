require 'httparty'
require_relative 'security/public_key'
require_relative 'requests'
require_relative 'requests/generate_signature'

module Mobilepay
    # Security requests
    class Security
        include HTTParty
        include Mobilepay::Security::PublicKey
        include Mobilepay::Requests
        include Mobilepay::Requests::GenerateSignature

        base_uri 'https://api.mobeco.dk/merchantsecurity/api'
        format :json

        attr_reader :privatekey, :headers, :body

        def initialize(args = {})
            @privatekey = args[:privatekey]
            @headers = { 'Ocp-Apim-Subscription-Key' => args[:subscription_key], 'Content-Type' => 'application/json' }
            @body = ''
        end
    end
end
