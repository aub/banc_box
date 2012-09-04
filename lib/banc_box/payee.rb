module BancBox
  class Payee

    attr_reader :account_number
    attr_reader :memo
    attr_reader :ach
    attr_reader :paypal
    attr_reader :check

    # Create a payee
    #
    # @return [BancBox::Payee] The payee object
    # @param data [Hash] A customizable set of options.
    # @option data [String] :account_number Number assigned to the new payee account designated by subscriber.
    # @option data [String] :memo
    # @option date [BancBox::BankAccount] :ach
    # @option date [BancBox::PaypalAccount] :paypal
    # @option date [BancBox::Check] :check
    def initialize(data)
      attrs = [
        :account_number, :memo, :ach, :paypal, :check
      ]
      attrs.each do |attr|
        instance_variable_set("@#{attr}", data[attr])
      end
    end

    def to_hash
      hash = {
        :payeeAccountNumber => @account_number,
        :memo => @memo,
        :payee => {}
      }
      if @ach
        hash[:payee][:ach] = @ach.to_hash
      elsif @paypal
        hash[:payee][:paypal] = @paypal.to_hash
      elsif @check
        hash[:payee][:check] = @check.to_hash
      end
    end
  end
end
