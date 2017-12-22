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

        private

        def generate_headers(uri)
            headers.merge('AuthenticationSignature' => generate_signature(uri))
        end

        def check_args(args)
            args.each do |arg_name, value|
                if value.nil?
                    raise Failure, "Invalid argument '#{arg_name}', must be string"
                end
            end
        end
    end
end
