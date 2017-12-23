module Mobilepay
    class Client
        # Merchants_GetPaymentTransactions
        module PaymentTransactions
            # Gets the transactions for a given order
            def payment_transactions(args = {})
                check_args(order_id: args[:order_id])
                response = request(:get, "/merchants/#{merchant_id}/orders/#{args[:order_id]}/transactions")
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
