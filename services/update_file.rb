require_relative './abstract_service.rb'

class UpdateFile < AbstractService

  def call
    translate(:enter_edit_path)
    path = gets.chomp

    return unless check_file_presence(path)

    FillFile.new.call(path)

    translate(:words_appended)
  end
end
