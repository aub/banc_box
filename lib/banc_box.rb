require 'faraday'
require 'faraday_middleware'

%w(config connection).each do |file|
  require File.join(File.dirname(__FILE__), 'bancbox', file)
end

module BancBox
  def self.configure
    yield Config
    Config
  end
end
