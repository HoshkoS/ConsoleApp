require_relative '../translation'

class NullAction
  include ::Translation

  def call(wait_time = 3)
    sleep(wait_time)
    translate(:nice_day)

    exit
  end
end
