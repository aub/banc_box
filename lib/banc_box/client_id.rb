module BancBox
  class ClientId

    # Create a new client id.
    #
    # @param options [Hash] Either a bancbox id or a reference id.
    #   One or the other is required.
    # @option options [Integer] :banc_box_id The bancbox id for the client.
    # @option options [String] :reference_id Your own id for the client.
    # @return [ClientId] The new id.
    def initialize(options={})
      @banc_box_id = options['banc_box_id']
      @reference_id = options['reference_id']
    end

    def raw_data=(data)
      @banc_box_id = data['bancBoxId']
      @reference_id = data['subscriberReferenceId']
    end

    def to_hash
      {
        :bancBoxId => @banc_box_id,
        :subscriberReferenceId => @reference_id
      }
    end
  end
end
