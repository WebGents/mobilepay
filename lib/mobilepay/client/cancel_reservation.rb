module Mobilepay
    class Client
        # Reservations_CancelReservation
        module CancelReservation
            # Cancels a specific reservation
            def cancel_reservation(args = {})
                check_args(order_id: args[:order_id])
                uri = "/reservations/merchants/#{merchant_id}/orders/#{args[:order_id]}"
                response = self.class.delete(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
