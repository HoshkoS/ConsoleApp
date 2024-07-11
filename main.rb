require 'i18n'

I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
I18n.default_locale = :en

MAX_ATTEMPTS = 5

def select_language
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
    end
end

select_language
