module Mobilepay
    class Client
        # Merchants_GetPaymentStatus
        module PaymentStatus
            # Gets the status of a given order
            def payment_status(args = {})
                check_args(order_id: args[:order_id])
                response = request(:get, "/merchants/#{merchant_id}/orders/#{args[:order_id]}")
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
