require 'spec_helper'

describe BancBox::Client do

  before do
    BancBox.configure do |config|
      config.base_url = 'https://sandbox-api.bancbox.com/BBXPortRest/'
      config.subscriber_id = 'sid'
      config.api_key = 'key'
      config.api_secret = 'secret'
    end
  end

  it 'should create a client and return its id' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/createClient"
    ).to_return(
      :status => 200,
      :body => {"clientId"=>{"bancBoxId"=>123}, "clientStatus"=>"ACTIVE", "requestId"=>123, "status"=>1}
    )
    data = BancBox::Client.create({
      :first_name => 'Aubrey',
      :last_name => 'Holland',
      :ssn => '555-55-5555',
      :dob => Date.today - 10000,
      :address => BancBox::Address.new({
        :line1 => '123 Elm Street.',
        :city => 'Brooklyn',
        :state => 'NY',
        :zipcode => '11238'
      }),
      :home_phone => '555-555-5555',
      :email => 'aubreyholland@gmail.com'
    })
    data.should be_an_instance_of(BancBox::Id)
    data.to_hash.should == {
      :bancBoxId => 123,
      :subscriberReferenceId => nil
    }
  end

  it 'should update a client and return some data' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/updateClient"
    ).to_return(
      :status => 200,
      :body => {"clientStatus"=>"ACTIVE", "requestId"=>1346686280079, "status"=>1, "warnings"=>nil}
    )
    data = BancBox::Client.update(
      BancBox::Id.new(:banc_box_id => 123),
      { :first_name => 'Aubrey' }
    )
    data.should be_an_instance_of(Hash)
    data.should == {
      "clientStatus"=>"ACTIVE",
      "requestId"=>1346686280079,
      "status"=>1,
      "warnings"=>nil
    }
  end

  it 'should update a client status' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/updateClientStatus"
    ).to_return(
      :status => 200,
      :body => {"newStatus"=>"INACTIVE", "requestId"=>1346686684904, "status"=>1, "warnings"=>nil}
    )
    data = BancBox::Client.update_status(
      BancBox::Id.new(:banc_box_id => 123),
      'INACTIVE'
    )
    data.should be_an_instance_of(Hash)
    data.should == {
      "newStatus"=>"INACTIVE",
      "requestId"=>1346686684904,
      "status"=>1,
      "warnings"=>nil
    }
  end

  it 'should search for clients' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/searchClients"
    ).to_return(
      :status => 200,
      :body => {
        'clients' => [
          {
            'clientId' => {'bancBoxId' => 895533},
            'firstName' => 'Mister',
            'lastName' => 'Holland',
            'ssn' => '5555',
          },
          {
            'clientId' => {'bancBoxId' => 895534},
            'firstName' => 'Mrs',
            'lastName' => 'Holland',
            'ssn' => '5556',
          }
        ]
      }
    )
    data = BancBox::Client.search(
      :created_on_from_date => Time.now - 10000000,
      :created_on_to_date => Time.now - 10000
    )
    data.should be_an_instance_of(Array)
    data.count.should == 2
    data.each { |i| i.should be_an_instance_of(BancBox::Client) }
  end

  it 'should get a client' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/getClient"
    ).to_return(
      :status => 200,
      :body => {
        'client' => {
          'clientId' => { 'bancBoxId' => 123 },
          'firstName' => 'Mister',
          'lastName' => 'Holland',
          'ssn' => '5555',
          'address' => {
            'line1' => '143 Elm St.',
            'city' => 'Brooklyn',
            'state' => 'NY',
            'zipcode' => '11238'
          },
          'homePhone' => '5555555555',
          'email' => 'aubreyholland@gmail.com',
          'status' => 'ACTIVE',
          'modifiedBy' => 68,
          'createdBy' => 68
        },
        'requestId' => 134,
        'status' => 1,
        'warnings' => nil,
        'errors' => nil
      }
    )
    data = BancBox::Client.get_client(
      BancBox::Id.new(:banc_box_id => 123)
    )
    data.should be_an_instance_of(BancBox::Client)
  end

  it 'should cancel a client' do
    WebMock.stub_request(
      :post,
      "https://sandbox-api.bancbox.com/BBXPortRest/cancelClient"
    ).to_return(
      :status => 200,
      :body => {"openAccounts"=>[{"id"=>{}}], "requestId"=>810, "status"=>1, "warnings"=>nil}
    )
    data = BancBox::Client.cancel(
      BancBox::Id.new(:banc_box_id => 123),
      'He deserved it'
    )
    data.should be_an_instance_of(Hash)
    data.should == {
      'openAccounts' => [{"id"=>{}}],
      'requestId' => 810,
      'status' => 1,
      'warnings' => nil 
    }
  end
end
