require 'i18n'
require 'fileutils'
require 'csv'
require 'ruby-progressbar'

require_relative 'services/language_selector'
require_relative 'services/create_file'
require_relative 'services/read_file'
require_relative 'services/fill_file'
require_relative 'services/update_file'
require_relative 'services/filter_file'
require_relative 'services/null_action'
require_relative './file_factory'


I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
I18n.default_locale = :en

MAX_ATTEMPTS = 5

INPUT_TO_ACTION_MAPPER = {
  1 => :read,
  2 => :create,
  3 => :update,
  4 => :filter
}

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
