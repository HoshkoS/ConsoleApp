require_relative './abstract_service.rb'

class NullAction < AbstractService

  def call(wait_time = 3)
    exit
  end
end
