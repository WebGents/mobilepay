module Mobilepay
    class Client
        module PaymentStatus

            # Merchants_GetPaymentStatus
            # Gets the status of a given order
            def payment_status(args = {})
                check_args(order_id: args[:order_id])
                response = call(:get, "/merchants/#{merchant_id}/orders/#{args[:order_id]}", { body: args[:body] || '' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end