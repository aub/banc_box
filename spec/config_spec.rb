require 'spec_helper'

describe BancBox::Config do
  it 'should allow me to set the api key and secret' do
    BancBox.configure do |config|
      config.subscriber_id = 'fff'
      config.api_key = 'abc'
      config.api_secret = '123'
    end
    BancBox::Config.subscriber_id.should == 'fff'
    BancBox::Config.api_key.should == 'abc'
    BancBox::Config.api_secret.should == '123'
  end
end

