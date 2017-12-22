describe Mobilepay::Client::CancelReservation do
    describe '.cancel_reservation' do
        let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222', privatekey: 'spec/fixtures/key.pvk') }

        context 'for bad request' do
            context 'for bad params' do
                it 'returns hash error with message' do
                    response = client.cancel_reservation

                    expect(response.is_a?(Hash)).to eq true
                    expect(response[:error]).to eq "Invalid argument 'order_id', must be string"
                end
            end
        end

        context 'for correct request' do
            it 'returns transaction id of the original reservation / payment' do
                stub_request(:delete, 'https://api.mobeco.dk/appswitch/api/v1/reservations/merchants/111/orders/333')
                    .to_return(status: 200, body: '{"TransactionId":"61872634691623746"}', headers: {})

                expect(client.cancel_reservation(order_id: '333')).to eq('TransactionId' => '61872634691623746')
            end
        end
    end
end
