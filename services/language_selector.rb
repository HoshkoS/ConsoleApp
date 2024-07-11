# TODO: find a way to remove 'require's from services
require_relative '../translation'

class LanguageSelector
  include Translation

  MAX_ATTEMPTS = 5

  def call
    attempt ||= 1
    translate(:select_language)
    puts I18n.available_locales.join("/")

    choice = gets.chomp.downcase
    I18n.locale = choice

    rescue I18n::InvalidLocale
      translate(:invalid_choice)

      if attempt < MAX_ATTEMPTS
        attempt += 1

        translate(:attempt_i, attempt: attempt, max_attempts: MAX_ATTEMPTS)
        retry
      else
        translate(:no_attempts_left)
        return
      end

    return true
  end
end
