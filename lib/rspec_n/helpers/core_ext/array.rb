class Array
  def to_sentence(word_connector: ", ", two_word_connector: " or ", last_word_connector: " or ")
    case length
    when 0
      ""
    when 1
      self[0].to_s.dup
    when 2
      "#{self[0]}#{two_word_connector}#{self[1]}"
    else
      "#{self[0...-1].join(word_connector)}#{last_word_connector}#{self[-1]}"
    end
  end
end
