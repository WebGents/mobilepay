module Mobilepay
    class Client
        # Reservations_CaptureAmount
        module CaptureAmount
            # Captures a previously reserved amount, either in full or partially
            def capture_amount(args = {})
                check_args(order_id: args[:order_id])
                uri = "/reservations/merchants/#{merchant_id}/orders/#{args[:order_id]}"
                @body = args[:body]
                response = self.class.put(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
