class LanguageSelector

  def call
    attempt ||= 1
    puts I18n.t(:select_language)
    puts I18n.available_locales.join("/")

    choice = gets.chomp.downcase
    I18n.locale = choice

    rescue I18n::InvalidLocale
      puts I18n.t(:invalid_choice)

      if attempt < MAX_ATTEMPTS
        attempt += 1

        puts I18n.t(:attempt_i, attempt: attempt, max_attempts: MAX_ATTEMPTS)
        retry
      else
        puts I18n.t(:no_attempts_left)
        return
      end

    return true
  end
end
