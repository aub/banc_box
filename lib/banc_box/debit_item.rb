module BancBox
  class DebitItem

    attr_reader :reference_id
    attr_reader :amount
    attr_reader :memo
    attr_reader :schedule_date

    # Create a debit item
    #
    # @return [BancBox::DebitItem] The debit item
    # @param attrs [Hash] A customizable set of options.
    # @option attrs [String] :reference_id
    # @option attrs [Float] :amount
    # @option attrs [String] :memo
    # @option attrs [Date] :schedule_date
    def initialize(attrs)
      @reference_id = attrs[:reference_id]
      @amount = attrs[:amount]
      @memo = attrs[:memo]
      @schedule_date = attrs[:schedule_date]
    end

    def to_hash
      {
        :referenceId => @reference_id,
        :amount => @amount,
        :memo => @memo,
        :scheduleDate => @schedule_date && @schedule_date.strftime('%Y-%m-%d')
      }
    end
  end
end
