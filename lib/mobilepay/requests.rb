require 'net/http'

module Mobilepay
    module Requests

        def generate_uri(address)
            URI("#{base_uri}#{address}")
        end

        def add_request_headers(req, body)
            req['Content-Type'] = 'application/json'
            req['Ocp-Apim-Subscription-Key'] = subscription_key
            req.body = body
            req
        end

    end
end