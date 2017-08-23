require 'digest/sha1'
require 'base64'
require 'jose'

module Mobilepay
    module Requests
        module GenerateSignature

            # Generate Authentication Signature
            def generate_signature(request)
                payload = (request.uri.to_s + request.body.to_s).encode('UTF-8')
                payload_sha1 = Digest::SHA1.digest(payload)
                payload_base64 = Base64.strict_encode64(payload_sha1)

                jwk = JOSE::JWK.from_pem_file(privatekey)
                JOSE::JWS.sign(jwk, payload_base64, { 'alg' => 'RS256', 'typ' => 'JWT' }).compact
            end

        end
    end
end