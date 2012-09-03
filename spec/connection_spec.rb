require 'spec_helper'

describe BancBox::Connection do
  let(:connection) { BancBox::Connection.new }

  before do
    BancBox.configure do |config|
      config.base_url = 'https://sandbox-api.bancbox.com/BBXPortRest/'
      config.subscriber_id = 'sid'
      config.api_key = 'key'
      config.api_secret = 'secret'
    end
  end

  it 'should automatically include the authentication data' do
     stub = WebMock.stub_request(
      :post,
      'https://sandbox-api.bancbox.com/createClient'
    ).with(:body => {
      'authentication' => {
        'apiKey' => 'key', 'secret' => 'secret'
      },
      'subscriberId' => 'sid'
    })
    connection.post('/createClient')
    stub.should have_been_requested
  end

  it 'should perform a post request' do
    stub = WebMock.stub_request(
      :post,
      'https://sandbox-api.bancbox.com/createClient'
    )
    connection.post('/createClient')
    stub.should have_been_requested
  end
end
