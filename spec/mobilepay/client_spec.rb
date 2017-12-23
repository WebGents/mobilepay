describe Mobilepay::Client do
    let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222', privatekey: 'spec/fixtures/key.pvk') }

    describe '.initialize' do
        it 'assigns merchant_id to @merchant_id' do
            expect(client.merchant_id).to eq '111'
        end

        it 'assigns privatekey to @privatekey' do
            expect(client.privatekey).to_not eq nil
        end
    end

    describe 'methods' do
        context '.check_args' do
            context 'for nil args' do
                it 'raises Failure with message' do
                    expect { client.send(:check_args, order_id: nil) }.to raise_error(Mobilepay::Failure, "Invalid argument 'order_id', must be string")
                end
            end

            context 'for args with value' do
                it 'returns args' do
                    expect(client.send(:check_args, order_id: '123')).to eq(order_id: '123')
                end
            end
        end
    end
end
