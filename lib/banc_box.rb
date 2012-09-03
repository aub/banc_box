require 'faraday'
require 'faraday_middleware'

%w(config connection).each do |file|
  require File.join(File.dirname(__FILE__), 'banc_box', file)
end

module BancBox
  def self.configure
    yield Config
    Config
  end

  def self.connection
    @connection ||= BancBox::Connection.new
  end
end
