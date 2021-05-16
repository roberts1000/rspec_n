class String
  # https://stackoverflow.com/questions/39743299/check-if-a-string-contains-only-digits-in-ruby
  def all_digits?
    match?(/\A\d+\z/)
  end

  def remove_color
    gsub(/\e\[(\d|;)+m/, "")
  end
end
