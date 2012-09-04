module BancBox
  class Funds

    extend BancBox::ApiService

    # not yet done:
    #  send
    #  transfer

    # Collect funds
    #
    # @see http://www.bancbox.com/api/view/29
    # @return [Hash] The data returned from the request.
    # @param options [Hash] A customizable set of options.
    # @option options [String] :method book, ach or creditcard
    # @option options [BancBox::Id] :destination_account_id The account to fund.
    # @option options [Array<BancBox::DebitItem>] :debit_items The debits.
    # @option options [Hash] :source The source of the funds.
    # @option options[source] [BancBox::Id] :linked_external_account_id
    # @option options[source] [BancBox::Id] :banc_box_account_id
    # @option options[source] [BancBox::BankAccount, BancBox::CreditCardAccount] :external_account
    def self.collect(options)
      data = {
        :method => options[:method],
        :items => options[:debit_items].map { |i| i.to_hash },
        :destinationAccount => options[:destination_account_id].to_hash,
        :source => {}
      }

      if (id = options[:source][:linked_external_account_id])
        data[:source][:linkedExternalAccount] = id.to_hash
      elsif (id = options[:source][:banc_box_account_id])
        data[:source][:account] = id.to_hash
      elsif BancBox::BankAccount === options[:source][:external_account]
        data[:source][:newExternalAccount][:bankAccount] =
          options[:source][:external_account].to_hash
      elsif BancBox::CreditCardAccount === options[:source][:external_account]
        data[:source][:newExternalAccount][:creditCardAccount] =
          options[:source][:external_account].to_hash
      end

      get_response(:post, 'collectFunds', data)
    end
  end
end
