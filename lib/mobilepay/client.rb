require 'httparty'
require_relative 'client/payment_status'
require_relative 'client/payment_transactions'
require_relative 'client/reservations'
require_relative 'client/refund_amount'
require_relative 'client/capture_amount'
require_relative 'client/cancel_reservation'
require_relative 'requests/generate_signature'

module Mobilepay
    # Clients requests
    class Client
        include HTTParty
        include Mobilepay::Client::PaymentStatus
        include Mobilepay::Client::PaymentTransactions
        include Mobilepay::Client::Reservations
        include Mobilepay::Client::RefundAmount
        include Mobilepay::Client::CaptureAmount
        include Mobilepay::Client::CancelReservation
        include Mobilepay::Requests::GenerateSignature

        base_uri 'https://api.mobeco.dk/appswitch/api/v1'
        format :json

        attr_reader :merchant_id, :privatekey, :headers, :body

        def initialize(args = {})
            @merchant_id = args[:merchant_id]
            @privatekey = args[:privatekey]
            @headers = { 'Ocp-Apim-Subscription-Key' => args[:subscription_key], 'Content-Type' => 'application/json' }
            headers['Test-mode'] = 'true' if args[:test_mode] == true
            @body = ''
        end

        private def request(type, uri)
            add_signature(uri)
            response = send_request(type, uri)
            check_response(response)
            response
        end

        private def add_signature(uri)
            headers['AuthenticationSignature'] = generate_signature(uri)
        end

        private def send_request(type, uri)
            case type
                when :get then self.class.get(uri, query: {}, headers: headers)
                when :put then self.class.put(uri, query: {}, headers: headers)
                when :delete then self.class.delete(uri, query: {}, headers: headers)
            end
        end

        private def check_args(args)
            args.each do |arg_name, value|
                if value.nil?
                    raise Failure, "Invalid argument '#{arg_name}', must be string"
                end
            end
        end

        private def check_response(response)
            if response.code != 200
                error_message = response.message.empty? ? response.code : response.message
                raise Failure, error_message
            end
        end
    end
end
