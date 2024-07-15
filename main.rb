require 'bundler/setup'
require 'i18n'
require 'csv'
require 'ruby-progressbar'

require_relative 'services/language_selector'
require_relative 'file_factory'
require_relative 'translation'

include Translation

I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
I18n.default_locale = :en

MAX_ATTEMPTS = 5

INPUT_TO_ACTION_MAPPER = {
  1 => :read,
  2 => :create,
  3 => :update,
  4 => :filter
}

at_exit do |wait_time = 3|
  sleep(wait_time)
  translate(:nice_day)
end

def main_menu
  loop do
    puts "1. #{I18n.t('main_menu.option_1')}"
    puts "2. #{I18n.t('main_menu.option_2')}"
    puts "3. #{I18n.t('main_menu.option_3')}"
    puts "4. #{I18n.t('main_menu.option_4')}"
    puts "0. #{I18n.t('main_menu.exit')}"
    input = gets.chomp.to_i

    FileFactory.call(INPUT_TO_ACTION_MAPPER[input])
  end
end

result = LanguageSelector.new.call

if result
  main_menu
end
