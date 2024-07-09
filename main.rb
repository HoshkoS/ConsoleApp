require 'bundler/setup'
require 'i18n'
require 'csv'
require 'ruby-progressbar'

require_relative 'services/language_selector'
require_relative 'services/create_file'
require_relative 'services/read_file'
require_relative 'services/fill_file'
require_relative 'services/update_file'
require_relative 'services/filter_file'


I18n.load_path << Dir[File.expand_path('locales') + '/*.yml']
I18n.default_locale = :en

def main_menu
  loop do
    puts "1. #{I18n.t('main_menu.option_1')}"
    puts "2. #{I18n.t('main_menu.option_2')}"
    puts "3. #{I18n.t('main_menu.option_3')}"
    puts "4. #{I18n.t('main_menu.option_4')}"
    puts "0. #{I18n.t('main_menu.exit')}"
    choice = gets.chomp.to_i

    case choice
    when 1
      ReadFile.new.call
    when 2
      CreateFile.new.call
    when 3
      UpdateFile.new.call
    when 4
      FilterFile.new.call
    when 0
      exit
    else
      puts I18n.t(:invalid_choice)
    end
  end
end

LanguageSelector.new.call

main_menu
