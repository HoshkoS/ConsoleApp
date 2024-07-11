class NullAction
  def call(wait_time = 3)
    sleep(wait_time)
    puts I18n.t(:nice_day)

    exit
  end
end
