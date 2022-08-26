require 'shellwords'

class ArgumentsHelper
  class << self
    def arguments
      if File.exist?(".rspec_n") && no_options_in_arguments?
        options = read_options_from_file
        if options.any?
          print "Reading options from `.rspec_n` file\n"
          return ARGV + options
        end
      end
      ARGV
    end

    # Read arguments from the config file only if no arguments are provided by user
    def no_options_in_arguments?
      ARGV.grep(/^-/).empty? # Match args that start with - (or --). Those are the options.
    end

    # Options can be listed on a single line in the config file, or listed on separate lines.
    def read_options_from_file
      Shellwords.shellwords File.read(".rspec_n").to_s.gsub(/\n|\r\n/, " ")
    end
  end
end
