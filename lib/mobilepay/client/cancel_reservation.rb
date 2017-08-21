module Mobilepay
    class Client
        module CancelReservation

            # Reservations_CancelReservation
            # Cancels a specific reservation
            def cancel_reservation(args = {})
                check_args(order_id: args[:order_id])
                response = call(:delete, "/reservations/merchants/#{merchant_id}/orders/#{args[:order_id]}", { body: '{}' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end