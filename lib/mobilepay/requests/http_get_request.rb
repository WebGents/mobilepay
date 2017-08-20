module Mobilepay
    module Requests
        module HttpGetRequest

            def http_get_request(address, args = {})
                uri = generate_uri(address)
                req = Net::HTTP::Get.new(uri)
                req = add_request_headers(req, args[:body])
                Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
            end

        end
    end
end