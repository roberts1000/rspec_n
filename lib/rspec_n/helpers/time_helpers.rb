module RspecN
  module TimeHelpers
    def convert_seconds_to_hms(total_seconds)
      hours = total_seconds / (60 * 60)
      minutes = (total_seconds / 60) % 60
      seconds = total_seconds % 60
      [hours, minutes, seconds].map do |t|
        # Right justify and pad with 0 until length is 2.
        # So if the duration of any of the time components is 0, then it will display as 00
        t.round.to_s.rjust(2, '0')
      end.join(':')
    end
  end
end
