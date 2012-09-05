module BancBox
  module Api

    # not yet done:
    #   linkFile
    #   getSchedules
    #   cancelSchedules
    #   collectFees
    #   linkPayee
    #   searchBancBoxPayees
    #   getClientLinkedPayees
    #   updateLinkedPayee
    #   sendFunds
    #   linkExternalAccount
    #   updateAccount
    #   getClientAccounts
    #   getClientLinkedExternalAccounts
    #   getAccountActivity
    #   updateLinkedExternalAccount
    #   closeAccount
    #   deleteLinkedExternalAccount

    # Register a new client
    #
    # @see http://www.bancbox.com/api/view/2
    # @return [Client] The new client object
    # @param options [Hash] A customizable set of options.
    # @option options [String] :reference_id An id for the client that you have generated.
    # @option options [String] :first_name The client's first name. Required.
    # @option options [String] :last_name The client's last name. Required.
    # @option options [String] :middle_initial The client's middle initial.
    # @option options [String] :ssn The client's social, in NNN-NN-NNNN format. Required.
    # @option options [Date] :dob The client's date of birth. Required.
    # @option options [BancBox::Address] :address The client's address. Required.
    # @options options [String] :home_phone The client's home phone #. Required.
    # @options options [String] :mobile_phone The client's mobile phone #.
    # @options options [String] :work_phone The client's work phone #.
    # @options options [String] :email The client's email address. Required.
    # @options options [String] :username Login username for BancBox client portal.
    def create_client(options)
      data = {
        :referenceId => options[:reference_id],
        :firstName => options[:first_name],
        :lastName => options[:last_name],
        :middleInitial => options[:middle_initial],
        :ssn => options[:ssn],
        :dob => formatted_date(options[:dob]),
        :address => options[:address] && options[:address].to_hash,
        :homePhone => options[:home_phone],
        :mobilePhone => options[:mobile_phone],
        :workPhone => options[:work_phone],
        :email => options[:email],
        :username => options[:username]
      }

      object_from_response(
        BancBox::Id,
        :post,
        'createClient',
        data,
        'clientId'
      )
    end

    # Update a client
    #
    # @see http://www.bancbox.com/api/view/12
    # @return [Hash] The returned data.
    # @param client_id [BancBox::Id] A client_id object.
    # @param options [Hash] A customizable set of options.
    # @option options [String] :reference_id An id for the client that you have generated.
    # @option options [String] :first_name The client's first name.
    # @option options [String] :last_name The client's last name.
    # @option options [String] :middle_initial The client's middle initial.
    # @option options [String] :ssn The client's social, in NNN-NN-NNNN format.
    # @option options [Date] :dob The client's date of birth, either a date or a string in 'YYYY-MM-DD format'.
    # @options options [BancBox::Address] :address The client's address.
    # @option options [String] :home_phone The client's home phone #.
    # @option options [String] :mobile_phone The client's mobile phone #.
    # @option options [String] :work_phone The client's work phone #.
    # @option options [String] :email The client's email address.
    # @option options [String] :username Login username for BancBox client portal.
    def update_client(client_id, options)
      data = {
        :clientId => client_id.to_hash,
        :firstName => options[:first_name],
        :lastName => options[:last_name],
        :middleInitial => options[:middle_initial],
        :ssn => options[:ssn],
        :dob => formatted_date(options[:dob]),
        :homePhone => options[:home_phone],
        :mobilePhone => options[:mobile_phone],
        :workPhone => options[:work_phone],
        :email => options[:email],
        :username => options[:username]
      }
      if options[:address]
        data[:address] = options[:address].to_hash
      end

      get_response(:post, 'updateClient', data)
    end

    # Update a client's status.
    #
    # @see http://www.bancbox.com/api/view/13
    # @return [Hash] The response data.
    # @param client_id [BancBox::Id] A client_id object.
    # @param client_status [String] The new status of the client specified enum{'ACTIVE', 'INACTIVE', 'SUSPENDED'}. Required.
    def update_client_status(client_id, client_status)
      data = {
        :clientId => client_id.to_hash,
        :clientStatus => client_status
      }

      get_response(:post, 'updateClientStatus', data)
    end

    # Search for clients.
    #
    # @see http://www.bancbox.com/api/view/8
    # @return [Array<BancBox::Client>] The client objects
    # @param options [Hash] A customizable set of options.
    # @option options [BancBox::Id] :client_id Search by client id.
    # @option options [Time] :created_on_from_date The start date.
    # @option options [Time] :created_on_to_date The end date.
    # @option options [Time] :modified_on_from_date The modified on start date.
    # @option options [Time] :modified_on_to_date The modified on end date.
    # @option options [String] :status Status of client, { 'ACTIVE', 'INACTIVE', 'CANCELLED', 'SUSPENDED', 'DELETED' }
    def search_clients(options)
      data = {
        :clientId => options[:client_id] && options[:client_id].to_hash,
        :createdOnFromDate => formatted_time(options[:created_on_from_date]),
        :createdOnToDate => formatted_time(options[:created_on_to_date]),
        :modifiedOnFromDate => formatted_time(options[:modified_on_from_date]),
        :modifiedOnToDate => formatted_time(options[:modified_on_to_date]),
        :status => options[:status]
      }
      collection_from_response(
        BancBox::Client,
        :post,
        'searchClients',
        data,
        'clients'
      )
    end

    # Find a client.
    #
    # @see http://www.bancbox.com/api/view/16
    # @return [BancBox::Client] The client object
    # @param client_id [BancBox::Id] A bancbox id.
    def get_client(client_id)
      data = {
        :clientId => client_id.to_hash
      }
      object_from_response(BancBox::Client, :post, 'getClient', data, 'client')
    end

    # Cancel a client.
    #
    # @see http://www.bancbox.com/api/view/10
    # @return [Hash] The response data
    # @param client_id [BancBox::Id] A client_id object.
    # @param comment [String] A comment about the cancellation.
    def cancel_client(client_id, comment)
      data = {
        :clientId => client_id.to_hash,
        :comment => comment
      }
      get_response(:post, 'cancelClient', data)
    end

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
    def collect_funds(options)
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
        data[:source][:newExternalAccount] = {
          :bankAccount => options[:source][:external_account].to_hash
        }
      elsif BancBox::CreditCardAccount === options[:source][:external_account]
        data[:source][:newExternalAccount] = {
          :creditCardAccount => options[:source][:external_account].to_hash
        }
      end
      get_response(:post, 'collectFunds', data)
    end

    # Open an account
    #
    # @see http://www.bancbox.com/api/view/29
    # @return [Hash] The data returned from the request.
    # @param options [Hash] A customizable set of options.
    # @option options [BancBox::Id] :client_id
    # @option options [String] :reference_id
    # @option options [String] :title
    # @option options [Boolean] :routable_for_credits
    # @option options [Boolean] :routable_for_debits
    def open_account(options)
      data = {
        :clientId => options[:client_id].to_hash,
        :referenceId => options[:reference_id],
        :title => options[:title],
        :routable => {
          :credits => boolean_to_yes_no(options[:routable_for_credits]),
          :debits => boolean_to_yes_no(options[:routable_for_debits])
        }
      }

      get_response(:post, 'openAccount', data)
    end

    # Transfer funds
    #
    # @see http://www.bancbox.com/api/view/26
    # @return [Hash] The data returned from the request.
    # @option options [BancBox::Id] :source_account_id The account to debit.
    # @option options [BancBox::Id] :destination_account_id The account to fund.
    # @option options [String] :memo
    # @option options [Array<BancBox::DebitItem>] :debit_items The debits.
    def transfer_funds(options)
      data = {
        :sourceAccount => options[:source_account_id].to_hash,
        :destinationAccount => options[:destination_account_id].to_hash,
        :memo => options[:memo],
        :items => options[:debit_items].map { |i| i.to_hash }
      }
      get_response(:post, 'transferFunds', data)
    end




    def formatted_time(time)
      time && time.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def formatted_date(date)
      date && date.strftime('%Y-%m-%d')
    end

    def boolean_to_yes_no(bool)
      bool ? 'YES' : 'NO'
    end

    def get_response(method, endpoint, data)
      response = BancBox.connection.__send__(method, endpoint, data)
      if response['errors'] != nil
        raise BancBox::Error.new(response['errors'])
      end
      response
    end

    def object_from_response(klass, method, endpoint, data, key)
      klass.from_response(get_response(method, endpoint, data)[key])
    end

    def collection_from_response(klass, method, endpoint, data, key)
      get_response(method, endpoint, data)[key.to_s].map do |i|
        klass.from_response(i)
      end
    end
  end
end
