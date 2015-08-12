class CheatActivity < Android::App::Activity

  def onCreate(saved_instance_state)
    super
    setContentView(R::Layout::Activity_cheat)
  end

end
