require 'spec_helper'

describe Mobilepay::Client::PaymentTransactions do
    describe '.payment_transactions' do
        let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222') }

        context 'for bad request' do
            context 'for bad params' do
                it 'returns hash error with message' do
                    response = client.payment_transactions

                    expect(response.is_a?(Hash)).to eq true
                    expect(response[:error]).to eq "Invalid argument 'order_id', must be string"
                end
            end
        end

        context 'for correct request' do
            it 'returns array with transactions associated with a specific payment' do
                stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/333/transactions').
                    to_return(status: 200, body: '[{"TimeStamp": "2016-04-08T07:45:36.533Z","PaymentStatus": "Captured","TransactionId": "61872634691623746","Amount": 11.5}]', headers: {})

                expect(client.payment_transactions(order_id: '333')).to eq [{"TimeStamp"=>"2016-04-08T07:45:36.533Z","PaymentStatus"=>"Captured","TransactionId"=>"61872634691623746","Amount"=>11.5}]
            end
        end
    end
end