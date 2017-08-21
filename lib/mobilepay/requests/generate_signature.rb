require 'digest/sha1'
require 'base64'
require 'jwt'

module Mobilepay
    module Requests
        module GenerateSignature

            # Generate Authentication Signature
            def generate_signature(request)
                payload = (request.uri.to_s + request.body.to_s).force_encoding('UTF-8')
                payload_sha1 = Digest::SHA1.hexdigest(payload)
                payload_base64 = Base64.encode64(payload_sha1)
                JWT.encode(payload_base64, privatekey, 'RS256')
            end

        end
    end
end