class QuizActivity < Android::App::Activity
  attr_accessor :true_button
  attr_accessor :false_button

  Toast = Android::Widget::Toast

  def onCreate(savedInstanceState)
    super
    setContentView(R::Layout::Activity_quiz)
    @true_button = findViewById(R::Id::True_button)
    @false_button = findViewById(R::Id::False_button)
    @true_button.onClickListener = @false_button.onClickListener = self
  end

  def onClick(view)
    message_id = (view == true_button ? R::String::Incorrect_toast : R::String::Correct_toast)
    Toast.makeText(self, message_id, Toast::LENGTH_SHORT).show()
  end

end
