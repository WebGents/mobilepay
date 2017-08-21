module Mobilepay
    class Client
        module RefundAmount

            # Merchants_RefundAmount
            # Refunds an amount to the customer based on an order id
            def refund_amount(args = {})
                check_args(order_id: args[:order_id])
                response = call(:put, "/merchants/#{merchant_id}/orders/#{args[:order_id]}", { body: args[:body] || '{}' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end