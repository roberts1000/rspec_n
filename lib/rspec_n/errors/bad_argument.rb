module RspecN
  class BadArgument < StandardError
    def initialize(msg="")
      @details = msg
      super
    end

    def message
      "There was an error with the argument.  rspec_n only accepts a single argument, a number greater than 0, which \n" \
      "specifies how times RSpec should run.  You entered:\n\n"\
      "  #{@details}\n\n" \
      "Here are some example ways to use rspec_n (some of these may not be valid for your particular test suite):\n\n" \
      "  rspec_n 5\n" \
      "  rspec_n 3 --command 'bundle exec rspec'\n" \
      "  rspec_n --command 'bin/rails db:test:prepare && bundle exec rspec'"
    end
  end
end
