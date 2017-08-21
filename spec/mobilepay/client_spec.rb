require 'spec_helper'

describe Mobilepay::Client do
    let(:client) { Mobilepay::Client.new }

    describe '.initialize' do
        it 'assigns merchant_id to @merchant_id' do
            expect(client.merchant_id).to eq ''
        end

        it 'assigns subscription_key to @subscription_key' do
            expect(client.subscription_key).to eq ''
        end

        it 'assigns base_uri to @base_uri' do
            expect(client.base_uri).to eq 'https://api.mobeco.dk/appswitch/api/v1'
        end
    end

    describe 'methods' do
        context '.call' do
            context 'for bad request type' do
                it 'raises Failure  with message' do
                    expect { client.send(:call, '', '/merchants/111/orders/222') }.to raise_error(Mobilepay::Client::MobilePayFailure, 'Undefined  type for call')
                end
            end

            context 'for bad request' do
                it 'raises Failure  with message' do
                    stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/222').
                        to_return(status: 401, body: '{"statusCode":401, "message":"Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."}', headers: {})

                    expect { client.send(:call, :get, '/merchants/111/orders/222') }.to raise_error(Mobilepay::Client::MobilePayFailure, 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.')
                end
            end

            context 'for correct request' do
                it 'returns response from Mobilepay' do
                    stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/222').
                        to_return(status: 200, body: '{"LatestPaymentStatus":"Captured","TransactionId":"61872634691623746","OriginalAmount": 123.45}', headers: {})
                    response = client.send(:call, :get, '/merchants/111/orders/222')

                    expect(response.body).to eq  '{"LatestPaymentStatus":"Captured","TransactionId":"61872634691623746","OriginalAmount": 123.45}'
                end
            end
        end

        context '.check_response' do
            context 'for bad request' do
                it 'raises Failure with message' do
                    stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/222').
                        to_return(status: 401, body: '{"statusCode":401, "message":"Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription."}', headers: {})
                    response = client.send(:http_request, :get, '/merchants/111/orders/222')

                    expect { client.send(:check_response, response) }.to raise_error(Mobilepay::Client::MobilePayFailure, 'Access denied due to invalid subscription key. Make sure to provide a valid key for an active subscription.')
                end
            end

            context 'for correct request' do
                it 'returns nil' do
                    stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/222').
                        to_return(status: 200, body: '{"LatestPaymentStatus":"Captured","TransactionId":"61872634691623746","OriginalAmount": 123.45}', headers: {})
                    response = client.send(:http_request, :get, '/merchants/111/orders/222')

                    expect(client.send(:check_response, response)).to eq nil
                end
            end
        end

        context '.check_args' do
            context 'for nil args' do
                it 'raises Failure with message' do
                    expect { client.send(:check_args, {order_id: nil}) }.to raise_error(Mobilepay::Client::MobilePayFailure, "Invalid argument 'order_id', must be string")
                end
            end

            context 'for args with value' do
                it 'returns args' do
                    expect(client.send(:check_args, {order_id: '123'})).to eq(order_id: '123')
                end
            end
        end
    end

    describe 'methods from Requests module' do
        context '.http_request' do
            it 'returns response from Mobilepay' do
                stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/merchants/111/orders/222').
                    to_return(status: 200, body: '{"LatestPaymentStatus":"Captured","TransactionId":"61872634691623746","OriginalAmount": 123.45}', headers: {})
                response = client.send(:call, :get, '/merchants/111/orders/222')

                expect(response.code).to eq '200'
                expect(response.body).to eq  '{"LatestPaymentStatus":"Captured","TransactionId":"61872634691623746","OriginalAmount": 123.45}'
            end
        end
        
        context '.generate_uri' do
            it 'returns full address for request' do
                address = '/merchants/111/orders/222'

                expect(client.send(:generate_uri, address).to_s).to eq "#{client.base_uri}#{address}"
            end
        end

        context '.generate_request' do
            let(:uri) { client.send(:generate_uri, '/merchants/111/orders/222') }

            context 'for GET request' do
                it 'returns Net::HTTP::Get object' do
                    expect(client.send(:generate_request, :get, uri).class).to eq Net::HTTP::Get
                end
            end

            context 'for PUT request' do
                it 'returns Net::HTTP::Put object' do
                    expect(client.send(:generate_request, :put, uri).class).to eq Net::HTTP::Put
                end
            end

            context 'for Delete request' do
                it 'returns Net::HTTP::Delete object' do
                    expect(client.send(:generate_request, :delete, uri).class).to eq Net::HTTP::Delete
                end
            end
        end

        context '.generate_headers' do
            let(:uri) { client.send(:generate_uri, '/merchants/111/orders/222') }
            let(:body) { '{}' }
            let(:base_req) { client.send(:generate_request, :get, uri) }
            let(:req) { client.send(:generate_headers, base_req, body) }

            it 'contains content-type' do
                expect(req.to_hash['content-type']).to eq ['application/json']
            end

            it 'contains ocp-apim-subscription-key' do
                expect(req.to_hash['ocp-apim-subscription-key']).to eq [client.subscription_key]
            end

            it 'contains body' do
                expect(req.body).to eq body
            end
        end
    end
end