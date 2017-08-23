describe Mobilepay::Client::Reservations do
    describe '.reservations' do
        let(:client) { Mobilepay::Client.new(merchant_id: '111', subscription_key: '222') }

        context 'for bad request' do
            context 'for bad params' do
                it 'returns hash error with message' do
                    response = client.reservations

                    expect(response.is_a?(Hash)).to eq true
                    expect(response[:error]).to eq "Invalid argument 'datetime_from', must be string"
                end
            end
        end

        context 'for correct request' do
            it 'returns a list of reservations made by a specific merchant, and optionally for a specific customer' do
                stub_request(:get, 'https://api.mobeco.dk/appswitch/api/v1/reservations/merchants/111/016-02-01T12_00/2016-02-01T13_30').
                    to_return(status: 200, body: '[{"TimeStamp": "2016-04-08T07_45_36Z","OrderId": "DB TESTING 2015060908","TransactionId": "61872634691623746","Amount": 100.25,"CaptureType": "Full"}]', headers: {})

                expect(client.reservations(datetime_from: '016-02-01T12_00', datetime_to: '2016-02-01T13_30')).to eq [{"TimeStamp"=>"2016-04-08T07_45_36Z","OrderId"=>"DB TESTING 2015060908","TransactionId"=>"61872634691623746","Amount"=>100.25,"CaptureType"=>"Full"}]
            end
        end
    end
end