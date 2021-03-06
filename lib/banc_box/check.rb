module BancBox
  class Check

    attr_reader :name
    attr_reader :address

    # Create a check destination
    #
    # @return [BancBox::Check] The check object
    # @param data [Hash] A customizable set of options.
    # @option data [String] :name
    # @option data [BancBox::Address] :address
    def initialize(data)
      @name = data[:name]
      @address = data[:address]
    end

    # Convert the check object to a hash appropriate for sending to BancBox
    #
    # @return [Hash] The data hash
    def to_hash
      hash = {
        :name => @name,
        :address => @address.to_hash
      }
    end
  end
end
