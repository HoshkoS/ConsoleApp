class FillFile

  def call(path)
    puts I18n.t(:enter_words)
    words = gets.chomp.split(',')

    words.map!(&:strip)
    valid_words = words.all? { |word| word.match?(/\A[a-zA-Z]+\z/) }

    unless valid_words
      puts I18n.t(:invalid_words)
      call(path)
      return
    end

    File.open(path, 'a') do |file|
      words.each { |word| file.puts word.strip }
    end
  end
end
