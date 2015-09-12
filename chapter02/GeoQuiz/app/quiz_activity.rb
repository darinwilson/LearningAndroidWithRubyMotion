class QuizActivity < Android::Support::V7::App::AppCompatActivity
  attr_accessor :true_button
  attr_accessor :false_button
  attr_accessor :next_button
  attr_accessor :previous_button
  attr_accessor :question_text_view
  attr_accessor :question_bank
  attr_accessor :current_index

  Toast = Android::Widget::Toast

  def onCreate(savedInstanceState)
    super
    setContentView(R::Layout::Activity_quiz)

    @question_bank = [
      Question.new(R::String::Question_oceans, true),
      Question.new(R::String::Question_mideast, false),
      Question.new(R::String::Question_africa, false),
      Question.new(R::String::Question_americas, true),
      Question.new(R::String::Question_asia, true),
    ]
    @current_index = 0

    @question_text_view = findViewById(R::Id::Question_text_view)
    # remember that in RubyMotion setText can be written as text=
    @question_text_view.text = question_bank[current_index].text_res_id

    @true_button = findViewById(R::Id::True_button)
    @false_button = findViewById(R::Id::False_button)
    @next_button = findViewById(R::Id::Next_button)
    @previous_button = findViewById(R::Id::Previous_button)
    @true_button.onClickListener =
      @false_button.onClickListener =
      @next_button.onClickListener =
      @previous_button.onClickListener =
      @question_text_view.onClickListener = self
  end

  def onClick(view)
    if view == next_button || view == previous_button || view == question_text_view
      self.current_index =
        (view == previous_button ? current_index - 1 : current_index + 1) % question_bank.length
      update_question
    else
      user_clicked_true = (view == true_button)
      message_id =
        if user_clicked_true == question_bank[current_index].true?
          R::String::Correct_toast
        else
          R::String::Incorrect_toast
        end
      Toast.makeText(self, message_id, Toast::LENGTH_SHORT).show()
    end

  end

  def onCreateOptionsMenu(menu)
    getMenuInflater().inflate(R::Menu::Menu_quiz, menu)
    true
  end

  def onOptionsItemSelected(item)
    if (item.itemId == R::Id::Action_settings)
      return true
    end
    super
  end

  private

  def update_question
    question_text_view.text = question_bank[current_index].text_res_id
  end
end
