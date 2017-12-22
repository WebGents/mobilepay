module Mobilepay
    class Client
        # Merchants_GetPaymentStatus
        module PaymentStatus
            # Gets the status of a given order
            def payment_status(args = {})
                check_args(order_id: args[:order_id])
                uri = "/merchants/#{merchant_id}/orders/#{args[:order_id]}"
                response = self.class.get(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
