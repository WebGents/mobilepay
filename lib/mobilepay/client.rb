require 'json'
require_relative 'client/payment_status'
require_relative 'client/payment_transactions'
require_relative 'client/reservations'
require_relative 'client/refund_amount'
require_relative 'client/capture_amount'
require_relative 'client/cancel_reservation'
require_relative 'requests'

module Mobilepay
    class Client
        include Mobilepay::Client::PaymentStatus
        include Mobilepay::Client::PaymentTransactions
        include Mobilepay::Client::Reservations
        include Mobilepay::Client::RefundAmount
        include Mobilepay::Client::CaptureAmount
        include Mobilepay::Client::CancelReservation
        include Mobilepay::Requests

        class MobilePayFailure < StandardError; end

        attr_reader :merchant_id, :subscription_key, :base_uri

        def initialize(args = {})
            @merchant_id = args[:merchant_id] || ''
            @subscription_key = args[:subscription_key] || ''
            @base_uri = 'https://api.mobeco.dk/appswitch/api/v1'
        end

        private

        def call(req, address, args = {})
            response = case req
                when :get, :put, :delete then http_request(req, address, args)
                else raise MobilePayFailure, 'Undefined  type for call'
            end
            check_response(response)
            response
        end

        def http_request(req, address, args = {})
                uri = generate_uri(address)
                req = generate_request(req, uri)
                req = generate_headers(req, args[:body])
                Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
            end

        def check_response(response)
            if response.code != '200'
                raise MobilePayFailure, JSON.parse(response.body)['message']
            end
        end

        def check_args(args)
            args.each do |arg_name, value|
                if value.nil? || !value.is_a?(String)
                    raise MobilePayFailure, "Invalid argument '#{arg_name}', must be string"
                end
            end
        end
    end
end