module BancBox
  class Id

    # Create a new banc_box id.
    #
    # @param options [Hash] Either a bancbox id or a reference id.
    #   One or the other is required.
    # @option options [Integer] :banc_box_id The bancbox id for the client.
    # @option options [String] :reference_id Your own id for the client.
    # @return [BancBox::Id] The new id.
    def initialize(options={})
      @banc_box_id = options[:banc_box_id]
      @reference_id = options[:reference_id]
    end

    def self.from_response(response)
      self.new(
        :banc_box_id => response['bancBoxId'],
        :reference_id => response['subscriberReferenceId']
      )
    end

    # Convert the id object to a hash appropriate for sending to BancBox
    #
    # @return [Hash] The data hash
    def to_hash
      {
        :bancBoxId => @banc_box_id,
        :subscriberReferenceId => @reference_id
      }
    end
  end
end
