require 'faraday'
require 'faraday_middleware'

files = [
  'api_service', 'account', 'address', 'bank_account', 'client',
  'config', 'connection', 'credit_card_account', 'debit_item',
  'error', 'funds', 'id'
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
