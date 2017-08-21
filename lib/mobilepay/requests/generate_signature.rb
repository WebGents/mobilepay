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
                payload_base64 = Base64.encode64(payload_sha1)

                jwk_rs256 = JOSE::JWK.generate_key([:rsa, 1024])
                jwk_rs256.kty.key = privatekey
                JOSE::JWS.sign(jwk_rs256, payload_base64, { "alg" => "RS256" }).compact
            end

        end
    end
end