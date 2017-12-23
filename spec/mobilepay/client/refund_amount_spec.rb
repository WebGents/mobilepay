describe Mobilepay::Client::RefundAmount do
    describe '.refund_amount' do
        let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222', privatekey: 'spec/fixtures/key.pvk') }

        context 'for bad request' do
            context 'for bad params' do
                it 'returns hash error with message' do
                    response = client.refund_amount

                    expect(response.is_a?(Hash)).to eq true
                    expect(response[:error]).to eq "Invalid argument 'order_id', must be string"
                end
            end
        end

        context 'for correct request' do
            it 'returns the remaining amount. If the transaction is completely refunded then this is 0.00' do
                stub_request(:put, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/333')
                    .to_return(status: 200, body: '{"TransactionId" : "61872634691623757","OriginalTransactionId" : "61872634691623746","Remainder" : 20.00}', headers: {})

                expect(client.refund_amount(order_id: '333', body: { 'Amount' => 100.00 })).to eq('TransactionId' => '61872634691623757', 'OriginalTransactionId' => '61872634691623746', 'Remainder' => 20.00)
            end
        end
    end
end
