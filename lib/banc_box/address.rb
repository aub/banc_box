module BancBox
  class Address

    attr_reader :line1
    attr_reader :line2
    attr_reader :city
    attr_reader :state
    attr_reader :zipcode

    # Create an address.
    #
    # @return [BancBox::Address] The address object
    # @param attrs [Hash] A customizable set of options.
    # @option attrs [String] :line1 The first line of the address.
    # @option attrs [String] :line2 The second line of the address.
    # @option attrs [String] :city The city name.
    # @option attrs [String] :state The state name.
    # @option attrs [String] :zipcode The zip code.
    def initialize(attrs)
      @line1 = attrs[:line1]
      @line2 = attrs[:line2]
      @city = attrs[:city]
      @state = attrs[:state]
      @zipcode = attrs[:zipcode]
    end

    # Create an address from a server response
    #
    # @return [BancBox::Address] The address object
    # @param response [Hash] The response data
    def self.from_response(response)
      if response
        self.new(response)
      end
    end

    # Convert the address object to a hash appropriate for sending to BancBox
    #
    # @return [Hash] The data hash
    def to_hash
      {
        :line1 => @line1,
        :line2 => @line2,
        :city => @city,
        :state => @state,
        :zipcode => @zipcode
      }
    end
  end
end
