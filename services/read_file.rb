require_relative '../translation'

class ReadFile
  include ::Translation

  def call
    translate(:enter_path)
    path = gets.chomp

    unless File.exist?(path)
      translate(:file_not_found)
      return
    end

    content = File.read(path)
    puts content
  end
end
