require 'json'
require_relative 'client/payment_status'
require_relative 'client/payment_transactions'
require_relative 'requests'
require_relative 'requests/http_get_request'

module Mobilepay
    class Client
        include Mobilepay::Client::PaymentStatus
        include Mobilepay::Client::PaymentTransactions
        include Mobilepay::Requests::HttpGetRequest

        class MobilePayFailure < StandardError; end

        attr_reader :merchant_id, :subscription_key, :base_uri

        def initialize(args = {})
            @merchant_id = args[:merchant_id]
            @subscription_key = args[:subscription_key]
            @base_uri = 'https://api.mobeco.dk/appswitch/api/v1'
        end

        private

        def call(req, address, args = {})
            response = case req
                when :get then http_get_request(address, args)
                else raise MobilePayFailure, 'Undefined  type for call'
            end
            check_response(response)
            response
        end

        def check_response(response)
            if response.code != '200'
                raise MobilePayFailure, JSON.parse(response.body)['message']
            end
        end
    end
end