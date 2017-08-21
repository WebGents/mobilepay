module Mobilepay
    class Security
        module PublicKey

            # Secutiry_PublicKey
            # Get MobilePay's public key to use when signing up new merchants
            def public_key
                response = call
                JSON.parse(response.body)
            rescue Failure => ex
                return { error: ex.message }
            end

        end
    end
end