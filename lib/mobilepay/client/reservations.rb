module Mobilepay
    class Client
        module Reservations

            # Reservations_GetReservations
            # Get the reservations for a particular date/time interval, and alternatively also for a specific customer
            def reservations(args = {})
                address = "/reservations/merchants/#{merchant_id}/#{args[:datetime_from]}/#{args[:datetime_to]}"
                address += "?customerId=#{args[:customer_id]}" if args[:customer_id].present?
                response = call(:get, address, { body: args[:body] || '' })
                JSON.parse(response.body)
            rescue MobilePayFailure => ex
                return { error: ex.message }
            end

        end
    end
end