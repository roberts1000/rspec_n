module RspecN
  class Runner < Cri::CommandRunner
    attr_reader :command, :iterations

    def initialize(options, args)
      input = Input.new(options, args)
      @iterations = input.iterations
      @command = input.command
      @formatter = Formatters::TableFormatter.new(runner: self)
      initialize_runs
    end

    def start
      display_intro
      @formatter.observe { run_tests }
    end

    def total_duration_seconds
      @runs.values.inject(0) { |sum, run| sum + run.duration_seconds }
    end

    def avg_duration_seconds
      (total_duration_seconds / @iterations).floor
    end

    private

    def initialize_runs
      @runs = {}
      @iterations.times { |i| @runs[i + 1] = Run.new(iteration: i + 1) }
    end

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
      iteration_part = "#{@iterations} times".colorize(:yellow)
      command_part = command.to_s.colorize(:yellow)
      puts "\nRSpec will execute #{iteration_part} using #{command_part}\n\n"
    end
  end
end
