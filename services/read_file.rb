require_relative './abstract_service.rb'

class ReadFile < AbstractService

  def call
    translate(:enter_path)
    path = gets.chomp

    return unless check_file_presence(path)

    content = File.read(path)
    puts content
  end
end
