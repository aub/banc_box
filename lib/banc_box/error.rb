module BancBox
  class Error < StandardError

    attr_reader :data

    def initialize(data)
      @data = data
      super(@data.inspect)
    end
  end
end


