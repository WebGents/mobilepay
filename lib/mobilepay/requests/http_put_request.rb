module Mobilepay
    module Requests
        module HttpPutRequest

            def http_put_request(address, args = {})
                uri = generate_uri(address)
                req = Net::HTTP::Put.new(uri)
                req = add_request_headers(req, args[:body])
                Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
            end

        end
    end
end