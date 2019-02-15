module RspecN
  class Run
    attr_accessor :iteration, :start_time, :finish_time, :seed, :rspec_stdout, :rspec_stderr, :rspec_status, :duration_seconds, :status_string

    def initialize(iteration:)
      @iteration = iteration
      @start_time = nil
      @finish_time = nil
      @duration_seconds = nil
      @seed = nil
      @rspec_stdout = nil
      @rspec_stderr = nil
      @rspec_status = nil
      @status_string = nil
    end

    def start_clock
      @start_time = Time.now
    end

    def stop_clock
      @finish_time = Time.now
      finalize_duration_seconds
      finalize_seed
      finalize_status_string
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

    private

    def finalize_duration_seconds
      @duration_seconds = (@finish_time - @start_time).round
    end

    def finalize_seed
      result = @rspec_stdout.match(/^Randomized with seed (\d*)/)
      return if result.nil?  # A seed wasn't used

      @seed = result.captures.first&.strip
    end

    def finalize_status_string
      return @status_string = "Pass with Warnings" if @rspec_status.to_i.zero? && !@rspec_stderr.empty?
      return @status_string = "Pass" if @rspec_status.to_i.zero?
      return @status_string = "Fail" if !@rspec_status.to_i.zero?
      @status_string = "Undetermined"
    end

  end
end
