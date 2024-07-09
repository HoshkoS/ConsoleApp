class FilterFile
  def call(wait_time = 5)
    puts I18n.t(:enter_path)
    input_file = gets.chomp

    unless File.exist?(input_file)
      puts I18n.t(:file_not_found)
      return
    end

    puts I18n.t(:enter_filtering_words)
    target_words = gets.chomp.split(',').map { _1.strip}

    total_rows = CSV.read(input_file).size

    progress_bar = ProgressBar.create(
      title: I18n.t(:filtering),
      total: total_rows,
      format: "%t: |%B| %p%% %e"
    )

    modified_rows = []
    mod_words_count = 0

    CSV.foreach(input_file) do |row|
      row.map! do |value|
        words = value.split(" ")
        words.map! do |word|
          if target_words.include?(word)
            mod_words_count += 1
            '*'
          else
            word
          end
        end

        words.join(" ")
      end

      modified_rows << row

      sleep(1)
      progress_bar.increment
    end

    copy_filename = File.basename(input_file).gsub('.csv','')

    CSV.open("new_files/#{copy_filename}_filtered.csv", 'w') do |csv|
      modified_rows.each do |row|
        csv << row
      end
    end

    progress_bar.finish
    puts I18n.t(:filtering_complete)
    puts I18n.t(:words_filtered, count: mod_words_count)
  end
end
