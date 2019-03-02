module RspecN
  class Run
    attr_accessor :duration_seconds, :finish_time, :iteration, :result_count_string, :rspec_stdout, :rspec_stderr, :rspec_status,
      :seed, :status_string, :start_time

    def initialize(iteration:)
      @duration_seconds = nil
      @finish_time = nil
      @iteration = iteration
      @result_count_string = nil
      @rspec_stdout = nil
      @rspec_stderr = nil
      @rspec_status = nil
      @seed = nil
      @skipped = false
      @status_string = nil
      @start_time = nil
    end

    def start_clock
      @start_time = Time.now
    end

    def stop_clock
      @finish_time = Time.now
      finalize_duration_seconds
      finalize_seed
      finalize_status_string
      finalize_result_count_string
    end

    def go(command)
      @rspec_stdout, @rspec_stderr, @rspec_status = Open3.capture3(command)
    end

    def formatted_start_time(format)
      start_time.strftime(format)
    end

    def formatted_finish_time(format)
      finish_time.strftime(format)
    end

    def passed?
      @status_string == "Pass"
    end

    def passed_with_warnings?
      @status_string == "Pass with Warnings"
    end

    def skip
      @skipped = true
      @duration_seconds = 0
    end

    def skipped?
      @skipped
    end

    def failed?
      @status_string == "Fail"
    end

    private

    def finalize_duration_seconds
      @duration_seconds = (@finish_time - @start_time).round
    end

    def finalize_seed
      result = @rspec_stdout.match(/^Randomized with seed (\d*)/)
      return if result.nil? # A seed wasn't used

      @seed = result.captures.first&.strip
    end

    # rubocop:disable Style/NegatedIf
    def finalize_status_string
      return @status_string = "Skip" if skipped?
      return @status_string = "Pass (Warnings)" if @rspec_status.exitstatus.zero? && !@rspec_stderr.empty?
      return @status_string = "Pass" if @rspec_status.exitstatus.zero?
      return @status_string = "Fail" if !@rspec_status.exitstatus.zero?

      @status_string = "Undetermined"
    end
    # rubocop:enable Style/NegatedIf

    def finalize_result_count_string
      result = @rspec_stdout.match(/\d*\s+examples?,\s+\d*\s+failures?(,\s+\d*\s+pending)*/)
      @result_count_string = result ? result.to_s : ""
    end
  end
end
