require_relative './abstract_service.rb'

class CreateFile < AbstractService

  def call
    translate(:enter_filename)
    filename = gets.chomp

    FileUtils.mkdir_p("new_files") unless Dir.exist?("new_files")

    if File.exist?("new_files/#{filename}.txt")
      translate(:file_exists)
      return
    end

    FillFile.new.call("new_files/#{filename}.txt")

    translate(:file_created)
  end
end
