module Mobilepay
    # Common requests for classes
    module Requests
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

        private def check_response(response)
            if response.code != 200
                error_message = response.message.empty? ? response.code : response.message
                raise Failure, error_message
            end
        end
    end
end
