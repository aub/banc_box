module BancBox
  class Funds

    extend BancBox::ApiService

    # not yet done:
    #  collect
    #  send
    #  transfer

    # Collect funds
    #
    # @see http://www.bancbox.com/api/view/29
    # @return [Hash] The data returned from the request.
    # @param options [Hash] A customizable set of options.
    # @option options [String] :reference_id An id for the client that you have generated.
    # @option options [String] :first_name The client's first name. Required.
    # @option options [String] :last_name The client's last name. Required.
    # @option options [String] :middle_initial The client's middle initial.
    # @option options [String] :ssn The client's social, in NNN-NN-NNNN format. Required.
    # @option options [Date] :dob The client's date of birth, either a date or a string in 'YYYY-MM-DD format'. Required.
    # @option options [Address] :address The client's address. Required.
    # @options options [String] :home_phone The client's home phone #. Required.
    # @options options [String] :mobile_phone The client's mobile phone #.
    # @options options [String] :work_phone The client's work phone #.
    # @options options [String] :email The client's email address. Required.
    # @options options [String] :username Login username for BancBox client portal.
    def self.collect(options)
    end
  end
end
