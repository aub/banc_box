module BancBox
  class Account

    extend BancBox::ApiService

    # not yet done:
    #  link_external
    #  update
    #  get_client_accounts
    #  get_client_linked_external_accounts
    #  activity
    #  update_linked_external_account
    #  close
    #  delete_linked_external_account

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
    def self.open(options)
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
  end
end
