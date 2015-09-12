class Question
  attr_accessor :text_res_id
  attr_accessor :answer_true

  def initialize(text_res_id, answer_true)
    @text_res_id = text_res_id
    @answer_true = answer_true
  end

  def true?
    answer_true == true
  end
end
