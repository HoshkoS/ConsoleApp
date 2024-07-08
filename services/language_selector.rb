class LanguageSelector

  def call
    begin
      puts I18n.t(:select_language)
      puts I18n.available_locales.join("/")

      choice = gets.chomp.downcase
      I18n.locale = choice
    rescue I18n::InvalidLocale
      puts I18n.t(:invalid_choice)
      retry
    end
  end
end
