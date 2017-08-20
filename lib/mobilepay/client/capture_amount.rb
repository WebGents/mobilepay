module Mobilepay
    class Client
        module CaptureAmount

            # Reservations_CaptureAmount
            # Captures a previously reserved amount, either in full or partially
            def capture_amount(args = {})
                response = call(:put, "/reservations/merchants/#{merchant_id}/orders/#{args[:order_id]}", { body: args[:body] || '' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end