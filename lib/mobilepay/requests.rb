require 'net/http'

module Mobilepay
    module Requests

        private

        def generate_uri(address)
            URI("#{base_uri}#{address}")
        end

        def generate_request(req, uri)
            case req
                when :get then Net::HTTP::Get.new(uri)
                when :put then Net::HTTP::Put.new(uri)
                when :delete then Net::HTTP::Delete.new(uri)
            end
        end

        def generate_headers(req, body)
            req['Content-Type'] = 'application/json'
            req['Ocp-Apim-Subscription-Key'] = subscription_key
            req.body = body
            req
        end

    end
end