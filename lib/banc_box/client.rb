module BancBox
  class Client

    # not yet done:
    #   linkFile
    #   getSchedules
    #   cancelSchedules
    #   collectFees

    def initialize(data)
      if data['clientId']
        @client_id = ClientId.new  
        @client_id.raw_data = data['clientId']
      end
      @status = data['clientStatus']
      @data = data
    end

    def id
      @client_id
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
    # @option options [Date] :dob The client's date of birth, either a date or a string in 'YYYY-MM-DD format'. Required.
    # @option options [Hash] :address The client's address. Required.
    # @options options[:address] [String] :line1 The first line of the address. Required.
    # @options options[:address] [String] :line2 The second line of the address.
    # @options options[:address] [String] :city The city of the address. Required.
    # @options options[:address] [String] :state The state of the address. Required.
    # @options options[:address] [String] :zipcode The zipcode of the address. Required.
    # @options options [String] :home_phone The client's home phone #. Required.
    # @options options [String] :mobile_phone The client's mobile phone #.
    # @options options [String] :work_phone The client's work phone #.
    # @options options [String] :email The client's email address. Required.
    # @options options [String] :username Login username for BancBox client portal.
    def self.create(options)
      dob = options[:dob]
      if dob && dob.is_a?(Date)
        dob = dob.strftime('%Y-%m-%d')
      end
      data = {
        :referenceId => options[:reference_id],
        :firstName => options[:first_name],
        :lastName => options[:last_name],
        :middleInitial => options[:middle_initial],
        :ssn => options[:ssn],
        :dob => dob,
        :address => {
          :line1 => options[:address][:line1],
          :line2 => options[:address][:line2],
          :city => options[:address][:city],
          :state => options[:address][:state],
          :zipcode => options[:address][:zipcode]
        },
        :homePhone => options[:home_phone],
        :mobilePhone => options[:mobile_phone],
        :workPhone => options[:work_phone],
        :email => options[:email],
        :username => options[:username]
      }
      parse_response(
        BancBox.connection.post('createClient', data)
      )
    end

    # Update a client
    #
    # @see http://www.bancbox.com/api/view/12
    # @return [Client] The client object
    # @param client_id [ClientId] A client_id object.
    # @param options [Hash] A customizable set of options.
    # @option options [String] :reference_id An id for the client that you have generated.
    # @option options [String] :first_name The client's first name.
    # @option options [String] :last_name The client's last name.
    # @option options [String] :middle_initial The client's middle initial.
    # @option options [String] :ssn The client's social, in NNN-NN-NNNN format.
    # @option options [Date] :dob The client's date of birth, either a date or a string in 'YYYY-MM-DD format'.
    # @options options [Hash] :address The client's address.
    # @option options[:address] [String] :line1 The first line of the address.
    # @option options[:address] [String] :line2 The second line of the address.
    # @option options[:address] [String] :city The city of the address.
    # @option options[:address] [String] :state The state of the address.
    # @option options[:address] [String] :zipcode The zipcode of the address.
    # @option options [String] :home_phone The client's home phone #.
    # @option options [String] :mobile_phone The client's mobile phone #.
    # @option options [String] :work_phone The client's work phone #.
    # @option options [String] :email The client's email address.
    # @option options [String] :username Login username for BancBox client portal.
    def self.update(client_id, options)
      dob = options[:dob]
      if dob && dob.is_a?(Date)
        dob = dob.strftime('%Y-%m-%d')
      end
      data = {
        :clientId => client_id.to_hash,
        :firstName => options[:first_name],
        :lastName => options[:last_name],
        :middleInitial => options[:middle_initial],
        :ssn => options[:ssn],
        :dob => dob,
        :homePhone => options[:home_phone],
        :mobilePhone => options[:mobile_phone],
        :workPhone => options[:work_phone],
        :email => options[:email],
        :username => options[:username]
      }
      if options[:address]
        data[:address] = {
          :line1 => options[:address][:line1],
          :line2 => options[:address][:line2],
          :city => options[:address][:city],
          :state => options[:address][:state],
          :zipcode => options[:address][:zipcode]
        }
      end
      parse_response(
        BancBox.connection.post('updateClient', data)
      )
    end

    # Update a client's status.
    #
    # @see http://www.bancbox.com/api/view/13
    # @return [Client] The client object
    # @param client_id [ClientId] A client_id object.
    # @param client_status [String] The new status of the client specified enum{'ACTIVE', 'INACTIVE', 'SUSPENDED'}. Required.
    def self.update_status(client_id, client_status)
      data = {
        :clientId => client_id.to_hash,
        :clientStatus => client_status
      }
      parse_response(
        BancBox.connection.post('updateClientStatus', data)
      )
    end

    # Cancel a client.
    #
    # @see http://www.bancbox.com/api/view/10
    # @return [Client] The client object
    # @param client_id [ClientId] A client_id object.
    # @param comment [String] A comment about the cancellation.
    def self.cancel(client_id, comment)
      data = {
        :clientId => client_id.to_hash,
        :comment => comment
      }
      parse_response(
        BancBox.connection.post('cancelClient', data)
      )
    end

    # Search for clients.
    #
    # @see http://www.bancbox.com/api/view/8
    # @return [Client] The client objects
    # @param options [Hash] A customizable set of options.
    # @option options [ClientId] :client_id Search by client id.
    # @option options [Time] :created_on_from_date The start date.
    # @option options [Time] :created_on_to_date The end date.
    # @option options [Time] :modified_on_from_date The modified on start date.
    # @option options [Time] :modified_on_to_date The modified on end date.
    # @option options [String] :status Status of client, { 'ACTIVE', 'INACTIVE', 'CANCELLED', 'SUSPENDED', 'DELETED' }
    def self.search(options)
      data = {
        :clientId => options[:client_id] && options[:client_id].to_hash,
        :createdOnFromDate => time_to_string(options[:created_on_from_date]),
        :createdOnToDate => time_to_string(options[:created_on_to_date]),
        :modifiedOnFromDate => time_to_string(options[:modified_on_from_date]),
        :modifiedOnToDate => time_to_string(options[:modified_on_to_date]),
        :status => options[:status]
      }
      parse_response(
        BancBox.connection.post('searchClients', data)
      )
    end

    # Find a client.
    #
    # @see http://www.bancbox.com/api/view/16
    # @return [Client] The client object
    # @param client_id [ClientId] A client_id object.
    def self.get_client(client_id)
      data = {
        :clientId => client_id.to_hash
      }
      parse_response(
        BancBox.connection.post('getClient', data)
      )
    end

    def self.time_to_string(date)
      date && date.strftime('%Y-%m-%dT%H:%M:%S')
    end

    def self.parse_response(response)
      puts response.inspect
      if !response['errors'].nil?
        raise BancBox::Error.new(response['errors'])
      elsif response['clients']
        response['clients'].map do |c|
          BancBox::Client.new(c)
        end
      elsif response['client']
        BancBox::Client.new(response['client']
      else
        BancBox::Client.new(response)
      end
    end
  end
end
