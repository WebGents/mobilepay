module Mobilepay
    class Client
        # Merchants_GetPaymentTransactions
        module PaymentTransactions
            # Gets the transactions for a given order
            def payment_transactions(args = {})
                check_args(order_id: args[:order_id])
                uri = "/merchants/#{merchant_id}/orders/#{args[:order_id]}/transactions"
                response = self.class.get(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
