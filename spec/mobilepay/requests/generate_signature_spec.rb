describe Mobilepay::Requests::GenerateSignature do
    describe '.generate_signature' do
        let(:client) { Mobilepay::Client.new privatekey: 'spec/fixtures/key.pvk' }
        let(:uri) { '/merchants/111/orders/222' }

        it 'returns token for signin' do
            token = client.send(:generate_signature, uri)

            expect(token).to_not eq ''
        end
    end
end
