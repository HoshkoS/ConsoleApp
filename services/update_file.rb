class UpdateFile

  def call
    puts I18n.t(:enter_edit_path)
    path = gets.chomp

    unless File.exist?(path)
      puts I18n.t(:file_not_found)
      return
    end

    FillFile.new.call(path)

    puts I18n.t(:words_appended)
  end
end
