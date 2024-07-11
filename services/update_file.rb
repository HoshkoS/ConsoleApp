require_relative '../translation'

class UpdateFile
  include ::Translation

  def call
    translate(:enter_edit_path)
    path = gets.chomp

    unless File.exist?(path)
      translate(:file_not_found)
      return
    end

    FillFile.new.call(path)

    translate(:words_appended)
  end
end
