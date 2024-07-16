require_relative '../../services/language_selector'

RSpec.describe LanguageSelector do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before do
    $stdin = input
    $stdout = output

    I18n.available_locales = [:en, :ua]
    I18n.backend.store_translations(:en, {
      select_language: 'Select a language:',
      invalid_choice: 'Invalid choice, please try again.',
      attempt_i: 'Attempt %{attempt} of %{max_attempts}.',
      no_attempts_left: 'No attempts left.'
    })
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT
  end

  it 'selects a valid language' do
    allow(input).to receive(:gets).and_return('en')

    subject.call
    output.rewind

    expect(output.read).to include 'en/ua'
    expect(I18n.locale).to eq(:en)
  end

  it 'retries on invalid language selection' do
    allow(input).to receive(:gets).and_return('ls', 'en')

    subject.call
    output.rewind

    expect(output.read).to include 'Invalid choice, please try again.'
    expect(I18n.locale).to eq(:en)
  end

  it 'stops after maximum attempts' do
    allow(input).to receive(:gets).and_return('ls', 'ls', 'ls', 'ls', 'ls')

    subject.call
    output.rewind

    expect(output.read).to include 'No attempts left.'
    expect(I18n.locale).to eq(:en)
  end
end
