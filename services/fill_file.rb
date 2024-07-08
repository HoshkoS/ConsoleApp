class FillFile
  def call(path)
    puts I18n.t(:enter_words)
    words = gets.chomp.split(',')

    File.open(path, 'a') do |file|
      words.each { |word| file.puts word.strip }
    end
  end
end
