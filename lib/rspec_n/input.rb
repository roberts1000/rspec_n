module RspecN
  class Input
    attr_accessor :iterations, :command, :stop_fast, :write_files
    def initialize(options, args)
      @args = args
      @options = options
      validate_args
      validate_order
      @iterations = determine_iterations
      @order = options.fetch(:order, "rand")
      @command = determine_command
      @stop_fast = options.fetch(:"stop-fast", false)
      @write_files = !options.fetch(:'no-file', false)
    end

    def write_files?
      @write_files
    end

    private

    def validate_args
      return if @args.size.zero?
      raise BadArgument, @args.join(', ') if @args.empty? || !@args.first.all_digits?
    end

    def validate_order
      return unless (order = @options.fetch(:order, nil))

      raise BadOption, order unless RspecN::ALLOWED_ORDER_OPTIONS.include?(order)
    end

    def determine_iterations
      @args.empty? ? RspecN::DEFAULT_ITERATIONS : @args.first.to_i
    end

    def determine_command
      return @options[:command] if @options.fetch(:command, nil)

      guessed_command + " --order " + @order
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
  end
end
