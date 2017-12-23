module Mobilepay
    class Security
        # Security_PublicKey
        module PublicKey
            # Gets the public key
            def public_key
                response = request(:get, '/publickey')
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
