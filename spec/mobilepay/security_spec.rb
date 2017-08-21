require 'spec_helper'

describe Mobilepay::Security do
    let(:security) { Mobilepay::Security.new }

    describe '.initialize' do
        it 'assigns subscription_key to @subscription_key' do
            expect(security.subscription_key).to eq ''
        end

        it 'assigns base_uri to @base_uri' do
            expect(security.base_uri).to eq 'https://api.mobeco.dk/merchantsecurity/api'
        end
    end

    describe 'methods' do
        context '.call' do
            context 'for bad request' do
                it 'raises Failure  with message' do
                    stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                        to_return(status: 401, body: '{"statusCode":401, "message":"Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."}', headers: {})

                    expect { security.send(:call) }.to raise_error(Mobilepay::Failure, 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.')
                end
            end

            context 'for correct request' do
                it 'returns response from Mobilepay Security' do
                    stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                        to_return(status: 200, body: '{"PublicKey":"-----BEGIN CERTIFICATE-----certificate body-----END CERTIFICATE-----"}', headers: {})
                    response = security.send(:call)

                    expect(response.body).to eq '{"PublicKey":"-----BEGIN CERTIFICATE-----certificate body-----END CERTIFICATE-----"}'
                end
            end
        end

        context '.check_response' do
            context 'for bad request' do
                it 'raises Failure with message' do
                    stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                        to_return(status: 401, body: '{"statusCode":401, "message":"Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."}', headers: {})
                    response = security.send(:http_request, :get, '/publickey')

                    expect { security.send(:check_response, response) }.to raise_error(Mobilepay::Failure, 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.')
                end
            end

            context 'for correct request' do
                it 'returns nil' do
                    stub_request(:get, 'https://api.mobeco.dk/merchantsecurity/api/publickey').
                        to_return(status: 200, body: '{"PublicKey":"-----BEGIN CERTIFICATE-----certificate body-----END CERTIFICATE-----"}', headers: {})
                    response = security.send(:call)

                    expect(security.send(:check_response, response)).to eq nil
                end
            end
        end
    end
end