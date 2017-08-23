describe Mobilepay::Client::PaymentStatus do
    describe '.payment_status' do
        let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222') }

        context 'for bad request' do
            context 'for bad params' do
                it 'returns hash error with message' do
                    response = client.payment_status

                    expect(response.is_a?(Hash)).to eq true
                    expect(response[:error]).to eq "Invalid argument 'order_id', must be string"
                end
            end
        end

        context 'for correct request' do
            it 'returns the status for a specific payment' do
                stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/333').
                    to_return(status: 200, body: '{"LatestPaymentStatus": "Captured","TransactionId": "61872634691623746","OriginalAmount": 123.45}', headers: {})

                expect(client.payment_status(order_id: '333')).to eq("LatestPaymentStatus"=>"Captured","TransactionId"=>"61872634691623746","OriginalAmount"=>123.45)
            end
        end
    end
end