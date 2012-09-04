module BancBox
  class CreditCardAccount

    attr_reader :track_data
    attr_reader :number
    attr_reader :expiry_month
    attr_reader :expiry_year
    attr_reader :type
    attr_reader :name
    attr_reader :cvv
    attr_reader :address

    # Create a credit card account.
    #
    # @return [BancBox::CreditCardAccount] The account object
    # @param data [Hash] A customizable set of options.
    # @option data [String] :track_data
    # @option data [String] :number
    # @option data [String] :expiry_month
    # @option data [String] :expiry_year
    # @option data [String] :type
    # @option data [String] :name
    # @option data [String] :cvv
    # @option data [BancBox::Address] :address
    def initialize(data)
      attrs = [
        :track_data, :number, :expiry_month, :expiry_year,
        :type, :name, :cvv, :address
      ]
      attrs.each do |attr|
        instance_variable_set("@#{attr}", data[attr])
      end
    end

    def to_hash
      {
        :trackdata => @track_data,
        :number => @number,
        :expiryDate => "#{@expiryMonth}/#{@expiryYear}",
        :type => @type,
        :name => @name,
        :cvv => @cvv,
        :address => @address.to_hash
      }
    end
  end
end
