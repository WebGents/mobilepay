describe Mobilepay::Security::PublicKey do
    describe '.public_key' do
        let(:security) { Mobilepay::Security.new(subscription_key: '222') }

        context 'for bad request' do
            it 'returns hash error with message' do
                stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                    to_return(status: 401, body: '{"statusCode":401, "message":"Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."}', headers: {})

                response = security.public_key

                expect(response.is_a?(Hash)).to eq true
                expect(response[:error]).to eq 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.'
            end
        end

        context 'for correct request' do
            it 'returns public key' do
                stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                    to_return(status: 200, body: '{"PublicKey":"-----BEGIN CERTIFICATE-----certificate body-----END CERTIFICATE-----"}', headers: {})

                expect(security.public_key).to eq({"PublicKey"=>"-----BEGIN CERTIFICATE-----certificate body-----END CERTIFICATE-----"})
            end
        end
    end
end