class String
  # https://stackoverflow.com/questions/39743299/check-if-a-string-contains-only-digits-in-ruby
  def all_digits?
    self =~ /\A\d+\z/ ? true : false
  end
end
