module Mobilepay
    module Requests
        module HttpGetRequest

            def http_get_request(address, args = {})
                uri = URI("#{base_uri}#{address}")
                req = Net::HTTP::Get.new(uri)
                req['Content-Type'] = 'application/json'
                req['Ocp-Apim-Subscription-Key'] = subscription_key
                req.body = args[:body]
                Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
            end

        end
    end
end