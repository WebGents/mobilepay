require 'spec_helper'

describe Mobilepay::Requests::GenerateSignature do
    describe '.generate_signature' do
        let(:client) { Mobilepay::Client.new privatekey: OpenSSL::PKey::RSA.generate(2048) }
        let(:uri) { client.send(:generate_uri, '/merchants/111/orders/222') }
        let(:req) { client.send(:generate_request, :get, uri) }

        it 'returns token for signin' do
            token = client.send(:generate_signature, req)

            puts token
            expect(token).to_not eq ''
        end
    end
end