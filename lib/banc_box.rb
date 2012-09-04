require 'faraday'
require 'faraday_middleware'

files = [
  'api_service', 'address', 'client', 'client_id', 'config',
  'connection', 'error'
]

files.each do |file|
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
