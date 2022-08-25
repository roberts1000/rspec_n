require 'shellwords'

class ArgumentsHelper
  class << self
    def get_arguments
      if File.exist?(".rspec_n") && no_options_in_arguments?
        options = read_options_from_file
        if options.any?
          print "Reading options from `.rspec_n` file\n"
          return ARGV + options
        end
      end
      ARGV
    end

    # Read arguments from file only if no arguments provided by user
    def no_options_in_arguments?
      ARGV.select{|a| a =~ /^\-/ }.empty? # Regex reads if an argument starts with - (so it's option)
    end

    def read_options_from_file
      Shellwords.shellwords File.read(".rspec_n").to_s.gsub(/\n|\r\n/, " ")
    end
  end
end
