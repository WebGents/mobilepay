module Mobilepay
    class Client
        # Reservations_GetReservations
        module Reservations
            # Get the reservations for a particular date/time interval, and alternatively also for a specific customer
            def reservations(args = {})
                check_args(datetime_from: args[:datetime_from], datetime_to: args[:datetime_to])
                uri = "/reservations/merchants/#{merchant_id}/#{args[:datetime_from]}/#{args[:datetime_to]}"
                uri += "?customerId=#{args[:customer_id]}" if args[:customer_id]
                response = self.class.get(uri, headers: generate_headers(uri), body: body)
                response.parsed_response
            rescue Failure => ex
                return { error: ex.message }
            end
        end
    end
end
