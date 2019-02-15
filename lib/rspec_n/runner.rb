module RspecN
  class Runner
    attr_reader :count, :command

    def initialize(count:, command:)
      @count = count
      @command = command
      @formatter = Formatters::TableFormatter.new(runner: self)
      initialize_runs
    end

    def initialize_runs
      @runs = {}
      @count.times { |i| @runs[i + 1] = Run.new(iteration: i + 1) }
    end

    def start
      display_intro
      @formatter.observe { run_tests }
    end

    def total_duration_seconds
      @runs.values.inject(0) { |sum, run| sum + run.duration_seconds }
    end

    def avg_duration_seconds
      (total_duration_seconds / @count).floor
    end

    private

    def run_tests
      @runs.each do |_iteration, run|
        run.start_clock
        @formatter.show_pre_run_info(run)
        run.go(@command)
        run.stop_clock
        @formatter.show_post_run_info(run)
      end
    end

    def display_intro
      count_part = "#{count} times".colorize(:yellow)
      command_part = command.to_s.colorize(:yellow)
      puts "\nRSpec will execute #{count_part} using #{command_part}\n\n"
    end
  end
end
