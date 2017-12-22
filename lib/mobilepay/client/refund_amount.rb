module Mobilepay
    class Client
        # Merchants_RefundAmount
        module RefundAmount
            # Refunds an amount to the customer based on an order id
            def refund_amount(args = {})
                check_args(order_id: args[:order_id])
                uri = "/merchants/#{merchant_id}/orders/#{args[:order_id]}"
                @body = args[:body]
                response = self.class.put(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
