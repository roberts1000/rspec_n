module RspecN
  module Formatters
    class TableFormatter
      include RspecN::TimeHelpers

      attr_accessor :columns

      def initialize(runner:)
        @runner = runner
        @columns = {
          "Run" => 7,
          "Start Time" => 21,
          "Finish Time" => 21,
          "Duration" => 12,
          "Seed" => 9,
          "Results" => 50
        }
        @header_columns_string = padded_header_column_labels
        @table_width = @header_columns_string.size
        @format = "%m/%d %l:%M:%S %p"
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
        puts result_count_field(run)
      end

      private

      def write_table_header
        puts @header_columns_string
        puts "-" * @table_width
      end

      def write_conclusion
        puts "-" * @table_width
        puts ""
        puts "Total Duration:              #{convert_seconds_to_hms(@runner.total_duration_seconds)}"
        puts "Average Duration:            #{convert_seconds_to_hms(@runner.avg_duration_seconds)}"
        puts "Total Passed:                #{@runner.total_passed.to_s.colorize(:green)}"
        puts "Total Failed:                #{@runner.total_failed.to_s.colorize(:red)}"
        puts "Total Skipped:               #{@runner.total_skipped}"
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
        value_size = value.to_s.remove_color.size
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

      def result_count_field(run)
        warning_part = run.has_warnings? ? " (Warnings)".colorize(:yellow) : ""
        run.result_count_string.colorize(result_color_symbol(run)) + warning_part
      end

      def result_color_symbol(run)
        case run.status_string
        when "Pass (Warnings)" then :green
        when "Pass" then :green
        when "Fail" then :red
        when "Skip" then :yellow
        else :yellow
        end
      end
    end
  end
end
