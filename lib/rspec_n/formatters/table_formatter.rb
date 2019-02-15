module RspecN
  module Formatters
    class TableFormatter
      include RspecN::TimeHelpers

      attr_accessor :columns

      def initialize(runner:)
        @runner = runner
        @columns = { "Run" => 8, "Start Time" => 22, "Finish Time" => 22, "Duration" => 13, "Seed" => 11, "Result" => 18 }
        @header_columns_string = padded_header_column_labels
        @table_width = @header_columns_string.size
        @format = "%m/%d %l:%M:%S %p"
      end

      def count
        @runner.count
      end

      def command
        @runner.command
      end

      def observe
        write_table_header
        yield
        write_conclusion
      end

      def show_pre_run_info(run)
        print pad_field("Run", run.iteration)
        print pad_field("Start Time", run.formatted_start_time(@format))
      end

      def show_post_run_info(run)
        print pad_field("Finish Time", run.formatted_finish_time(@format))
        print duration_field(run)
        print seed_field(run)
        puts result_field(run)
      end

      private

      def write_table_header
        puts @header_columns_string
        puts "-" * @table_width
      end

      def write_conclusion
        puts "-" * @table_width
        puts ""
        puts "Total Duration:   #{convert_seconds_to_hms(@runner.total_duration_seconds)}"
        puts "Average Duration: #{convert_seconds_to_hms(@runner.avg_duration_seconds)}"
        puts ""
      end

      def padded_header_column_label(name, width)
        right_padding = width - name.size
        name + (" " * right_padding)
      end

      def padded_header_column_labels
        columns.collect { |name, max_width| padded_header_column_label(name, max_width) }.join("")
      end

      def max_column_width_for(name)
        columns[name]
      end

      def pad_field(column_name, value)
        max_width = max_column_width_for(column_name)
        value_size = value.to_s.size
        pad_count = max_width - value_size
        value.to_s + (" " * pad_count)
      end

      def duration_field(run)
        hms = convert_seconds_to_hms(run.duration_seconds)
        pad_field("Duration", hms)
      end

      def seed_field(run)
        run.seed.nil? ? pad_field("Seed", "None") : pad_field("Seed", run.seed)
      end

      def result_field(run)
        case run.status_string
        when "Pass with Warnings" then "Pass with Warnings".colorize(:yellow)
        when "Pass" then "Pass".colorize(:green)
        when "Fail" then "Fail".colorize(:red)
        else "Unknown".colorize(:yellow)
        end
      end
    end
  end
end
