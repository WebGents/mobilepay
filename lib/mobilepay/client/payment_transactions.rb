module Mobilepay
    class Client
        module PaymentTransactions

            # Merchants_GetPaymentTransactions
            # Gets the transactions for a given order
            def payment_transactions(args = {})
                check_args(order_id: args[:order_id])
                response = call(:get, "/merchants/#{merchant_id}/orders/#{args[:order_id]}/transactions", { body: '{}' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end