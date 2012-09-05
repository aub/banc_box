module BancBox
  class Client

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
  end
end
