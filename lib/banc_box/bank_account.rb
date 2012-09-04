module BancBox
  class BankAccount

    attr_reader :routing_number
    attr_reader :account_number
    attr_reader :holder_name
    attr_reader :type

    # Create a bank account.
    #
    # @return [BancBox::BankAccount] The account object
    # @param data [Hash] A customizable set of options.
    # @option data [String] :routing_number
    # @option data [String] :account_number
    # @option data [String] :holder_name
    # @option data [String] :type
    def initialize(data)
      @routing_number = data[:routing_number]
      @account_number = data[:account_number]
      @holder_name = data[:holder_name]
      @type = data[:type]
    end

    def to_hash
      {
        :routingNumber => @track_data,
        :accountNumber => @account_number,
        :holderName => @holder_name,
        :bankAccountType => @type
      }
    end
  end
end
