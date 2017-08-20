module Mobilepay
    class Client
        module CancelReservation

            # Reservations_CancelReservation
            # Cancels a specific reservation
            def cancel_reservation(args = {})
                response = call(:delete, "/reservations/merchants/#{merchant_id}/orders/#{args[:order_id]}", { body: args[:body] || '' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end