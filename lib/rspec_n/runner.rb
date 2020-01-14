module RspecN
  class Runner < Cri::CommandRunner
    attr_reader :command, :input, :iterations, :runs

    def initialize(options, args)
      @input = Input.new(options, args)
      @iterations = @input.iterations
      @command = @input.command
      @display_formatter = Formatters::TableFormatter.new(runner: self)
      @file_formatter = Formatters::FileFormatter.new(runner: self)
      initialize_runs
    end

    def start
      display_intro
      @display_formatter.observe { run_tests }
    end

    def total_duration_seconds
      @runs.values.inject(0) { |sum, run| sum + run.duration_seconds }
    end

    def avg_duration_seconds
      (total_duration_seconds / @iterations).floor
    end

    def total_passed
      @runs.values.count(&:passed?)
    end

    def total_failed
      @runs.values.count(&:failed?)
    end

    def total_skipped
      @runs.values.count(&:skipped?)
    end

    private

    def initialize_runs
      @runs = {}
      @iterations.times { |i| @runs[i + 1] = Run.new(iteration: i + 1) }
    end

    def run_tests
      found_failure = false

      @runs.each do |_iteration, run|
        next run.skip if @input.stop_fast && found_failure

        run.start_clock
        @display_formatter.show_pre_run_info(run)
        run.go(@command)
        run.stop_clock
        @display_formatter.show_post_run_info(run)
        found_failure ||= run.failed?
        @file_formatter.write(run, @command)
      end
    end

    def display_intro
      iteration_part = @iterations > 1 ? "#{@iterations} times" : "1 time"
      puts "\nRSpec will execute #{iteration_part.colorize(:yellow)} using #{command.to_s.colorize(:yellow)}\n\n"
    end
  end
end
