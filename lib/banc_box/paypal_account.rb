module BancBox
  class PayPalAccount

    attr_reader :id

    # Create a paypal account.
    #
    # @return [BancBox::CreditCardAccount] The account object
    # @param id [String]
    def initialize(id)
      @id = id
    end

    # Convert the account object to a hash appropriate for sending to BancBox
    #
    # @return [Hash] The data hash
    def to_hash
      { :id => @id }
    end
  end
end
