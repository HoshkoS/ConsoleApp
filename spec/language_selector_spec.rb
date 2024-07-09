require_relative '../services/language_selector'

RSpec.describe LanguageSelector do
  let(:language_selector) { LanguageSelector.new }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before do
    $stdin = input
    $stdout = output
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT
  end

  it 'selects a valid language' do
    allow(input).to receive(:gets).and_return('en')

    language_selector.call
    output.rewind

    expect(output.read).to include I18n.t(:select_language)
    expect(I18n.locale).to eq(:en)
  end

  it 'retries on invalid language selection' do
    allow(input).to receive(:gets).and_return('ls', 'en')

    language_selector.call
    output.rewind

    expect(output.read).to include I18n.t(:select_language), I18n.t(:invalid_choice)
    expect(I18n.locale).to eq(:en)
  end
end
