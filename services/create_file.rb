class CreateFile

  def call
    puts I18n.t(:enter_filename)
    filename = gets.chomp

    FileUtils.mkdir_p("new_files") unless Dir.exist?("new_files")

    if File.exist?("new_files/#{filename}.txt")
      puts I18n(:file_exists)
      return
    end

    FillFile.new.call("new_files/#{filename}.txt")

    puts I18n.t(:file_created)
  end
end