module BancBox
  class Client

    extend BancBox::ApiService

    # not yet done:
    #   linkFile
    #   getSchedules
    #   cancelSchedules
    #   collectFees

    # Create a new client instance
    #
    # @return [Client] The new client object
    # @param data [Hash] A customizable set of data.
    # @option data [BancBox::Id] :client_id Client id.
    # @option data [String] :first_name The client's first name.
    # @option data [String] :last_name The client's last name.
    # @option data [String] :middle_initial The client's middle initial.
    # @option data [String] :ssn The client's social.
    # @option data [BancBox::Address] :address The client's address.
    # @option data [String] :home_phone The client's home phone #.
    # @option data [String] :mobile_phone The client's mobile phone #.
    # @option data [String] :work_phone The client's work phone #.
    # @option data [String] :email The client's email address.
    # @option data [String] :username Username for BancBox client portal.
    # @option data [String] :status The user status
    # @option data [Integer] :modified_by
    # @option data [Integer] :created_by
    def initialize(data)
      attrs = [
        :client_id, :first_name, :last_name, :middle_initial, :ssn,
        :address, :home_phone, :mobile_phone, :work_phone, :email,
        :username, :status, :modified_by, :created_by
      ]
      attrs.each do |attr|
        instance_variable_set("@#{attr}", data[attr])
      end
    end

    def self.from_response(response)
      self.new({
        :client_id => BancBox::Id.from_response(response['clientId']),
        :first_name => response['firstName'],
        :last_name => response['lastName'],
        :middle_initial => response['middleInitial'],
        :ssn => response['ssn'],
        :address => BancBox::Address.from_response(response['address']),
        :home_phone => response['homePhone'],
        :mobile_phone => response['mobilePhone'],
        :email => response['email'],
        :username => response['username'],
        :status => response['status'],
        :modified_by => response['modifiedBy'],
        :created_by => response['createdBy']
      })
    end

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
    def self.create(options)
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
    def self.update(client_id, options)
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
    def self.update_status(client_id, client_status)
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
    def self.search(options)
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
    def self.get_client(client_id)
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
    def self.cancel(client_id, comment)
      data = {
        :clientId => client_id.to_hash,
        :comment => comment
      }
      get_response(:post, 'cancelClient', data)
    end
  end
end
