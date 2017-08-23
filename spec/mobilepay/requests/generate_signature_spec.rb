describe Mobilepay::Requests::GenerateSignature do
    describe '.generate_signature' do
        let(:client) { Mobilepay::Client.new privatekey: "#{Dir.pwd}/spec/fixtures/key.pvk" }
        let(:uri) { client.send(:generate_uri, '/merchants/111/orders/222') }
        let(:req) { client.send(:generate_request, :get, uri) }

        it 'returns token for signin' do
            token = client.send(:generate_signature, req)

            expect(token).to_not eq ''
        end
    end
end