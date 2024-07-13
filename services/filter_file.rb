require_relative '../translation'

class FilterFile
  include ::Translation

  def call(wait_time = 1)
    return unless get_file

    mod_rows, mod_words_count = filter_file(target_words, wait_time)

    create_copy(mod_rows)
    show_result(mod_words_count)
  end

  private

  attr_reader :input_file, :progress_bar

  def get_file
    translate(:enter_path)
    input = gets.chomp

    @input_file = check_file_presence(input)
  end

  def filter_file(filter_words, wait_time)
    create_progress_bar

    modified_rows = []
    mod_words_count = 0

    CSV.foreach(input_file) do |row|
      row.map! do |value|
        words = value.split(" ")
        words.map! do |word|
          if filter_words.include?(word)
            mod_words_count += 1
            '*'
          else
            word
          end
        end

        words.join(" ")
      end

      modified_rows << row

      sleep(wait_time)
      progress_bar.increment
    end

    return modified_rows, mod_words_count
  end

  def create_copy(modified_rows)
    copy_filename = File.basename(input_file).gsub('.csv','')

    CSV.open("new_files/#{copy_filename}_filtered.csv", 'w') do |csv|
      modified_rows.each do |row|
        csv << row
      end
    end

    progress_bar.finish
  end

  def create_progress_bar
    total_rows = CSV.read(input_file).size

    @progress_bar = ProgressBar.create(
      title: I18n.t(:filtering),
      total: total_rows,
      format: "%t: |%B| %p%% %e"
    )
  end

  def target_words
    translate(:enter_filtering_words)
    target_words = gets.chomp.split(',').map { _1.strip}
  end

  def show_result(word_count)
    translate(:filtering_complete)
    translate(:words_filtered, count: word_count)
  end
end
