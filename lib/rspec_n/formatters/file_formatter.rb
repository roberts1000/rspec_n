module RspecN
  module Formatters
    class FileFormatter
      include RspecN::TimeHelpers

      BASE_FILE_NAME = "rspec_n_iteration".freeze

      def initialize(runner:)
        @runner = runner
        @format = "%m/%d %l:%M:%S %p"
        delete_all_files
      end

      def delete_all_files
        log_directory = Pathname.new(@runner.input.log_path)
        Dir.glob(log_directory.join("#{BASE_FILE_NAME}.**")).each { |file| File.delete(file) }
      end

      def write(run, command)
        return if run.skipped?
        return unless @runner.input.write_files?

        log_directory = Pathname.new(@runner.input.log_path)
        FileUtils.mkdir_p(log_directory)
        file_path = log_directory.join("#{BASE_FILE_NAME}.#{run.iteration}")

        File.open(file_path, "w") do |f|
          f.write("Iteration: #{run.iteration}\n")
          f.write("Start Time: #{run.formatted_start_time(@format)}\n")
          f.write("Finish Time: #{run.formatted_finish_time(@format)}\n")
          f.write("Duration: #{convert_seconds_to_hms(run.duration_seconds)}\n")
          f.write("Command: #{command}\n\n")
          f.write(run.rspec_stdout)
          f.write(run.rspec_stderr)
        end
      end
    end
  end
end
