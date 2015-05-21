class TrueFalse
  attr_accessor :question
  attr_accessor :is_true

  def initialize(question, is_true)
    @question = question
    @is_true = is_true
  end

  def true?
    is_true == true
  end
end
