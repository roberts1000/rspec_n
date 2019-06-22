module RspecN
  class Input
    attr_accessor :iterations, :command, :stop_fast, :write_files
    def initialize(options, args)
      @args = args
      @unprocessed_args_array = args.entries
      @options = options
      @iterations = determine_iterations
      @spec_path = determine_spec_path
      validate_order
      @order = @options.fetch(:order, "rand")
      @command = determine_command
      @stop_fast = options.fetch(:"stop-fast", false)
      @write_files = !options.fetch(:'no-file', false)
    end

    def write_files?
      @write_files
    end

    private

    def validate_order
      return unless (order = @options.fetch(:order, nil))

      raise BadOption, order unless RspecN::ALLOWED_ORDER_OPTIONS.include?(order)
    end

    def determine_iterations
      value = @unprocessed_args_array.detect(&:all_digits?)

      if value
        @unprocessed_args_array.delete(value)
        value.to_i
      else
        RspecN::DEFAULT_ITERATIONS
      end
    end

    def determine_spec_path
      @unprocessed_args_array.empty? ? nil : @unprocessed_args_array.join(" ")
    end

    def determine_command
      command = @options.fetch(:command, guessed_command)
      command += " " + @spec_path if @spec_path
      command += " --order " + @order if should_append_order?(command)
      command
    end

    def guessed_command
      return RspecN::DEFAULT_RSPEC_STARTER_COMMAND if project_uses_rspec_starter?
      return RspecN::DEFAULT_RAILS_COMMAND if project_is_rails_based?

      RspecN::DEFAULT_COMMAND
    end

    def project_uses_rspec_starter?
      app_file_name = "bin/start_rspec"
      File.file?(app_file_name)
    end

    def project_is_rails_based?
      app_file_name = "config/application.rb"
      File.file?(app_file_name) && File.readlines(app_file_name).grep(/Rails::Application/).any?
    end

    def should_append_order?(command)
      command.match(/--order/).nil?
    end
  end
end
