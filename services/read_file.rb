class ReadFile

  def call
    puts I18n.t(:enter_path)
    path = gets.chomp

    unless File.exist?(path)
      puts I18n.t(:file_not_found)
      return
    end

    content = File.read(path)
    puts content
  end
end
