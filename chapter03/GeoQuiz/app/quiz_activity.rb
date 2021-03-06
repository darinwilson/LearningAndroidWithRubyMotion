class QuizActivity < Android::Support::V7::App::AppCompatActivity
  attr_accessor :true_button
  attr_accessor :false_button
  attr_accessor :next_button
  attr_accessor :question_text_view
  attr_accessor :question_bank
  attr_accessor :current_index

  Toast = Android::Widget::Toast

  # a key for storing the current index
  KEY_INDEX = "current_index"

  def onCreate(saved_instance_state)
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
    if saved_instance_state
      @current_index = saved_instance_state.getInt(KEY_INDEX, 0)
    end

    @question_text_view = findViewById(R::Id::Question_text_view)
    update_question

    @true_button = findViewById(R::Id::True_button)
    @false_button = findViewById(R::Id::False_button)
    @next_button = findViewById(R::Id::Next_button)
    @true_button.onClickListener =
      @false_button.onClickListener =
      @next_button.onClickListener = self
  end

  def onSaveInstanceState(saved_instance_state)
    super
    debug "onSaveInstanceState"
    saved_instance_state.putInt(KEY_INDEX, current_index)
  end

  def onClick(view)
    if view == next_button || view == question_text_view
      self.current_index = (current_index + 1) % question_bank.length
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

  def onStart
    super
    debug "onStart called"
  end

  def onPause
    super
    debug "onPause called"
  end

  def onResume
    super
    debug "onResume called"
  end

  def onStop
    super
    debug "onStop called"
  end

  def onDestroy
    super
    debug "onDestroy called"
  end

  private

  def update_question
    question_text_view.text = question_bank[current_index].text_res_id
  end

  def debug(message)
    Android::Util::Log.d("QuizActivity", message)
  end

end
