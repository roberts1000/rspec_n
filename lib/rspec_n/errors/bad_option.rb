module RspecN
  class BadOption < StandardError
    def initialize(msg="")
      @details = msg
      super
    end

    def message
      allowed = RspecN::ALLOWED_ORDER_OPTIONS.collect { |val| "'" + val + "'" }
      "Order must be #{allowed.to_sentence}.  '#{@details}' is not allowed.\n"
    end
  end
end
