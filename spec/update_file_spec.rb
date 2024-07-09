require_relative '../services/update_file'  # Adjust the path as needed
require_relative '../services/fill_file'    # Adjust the path as needed

RSpec.describe UpdateFile do
  let(:update_file) { UpdateFile.new }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:file_path) { 'test_update_file.txt' }
  let(:file_content) { 'Existing content.' }
  let(:new_words) { 'new,words' }

  before(:each) do
    $stdin = input
    $stdout = output

    File.write(file_path, file_content)
  end

  after(:each) do
    $stdin = STDIN
    $stdout = STDOUT

    File.delete(file_path) if File.exist?(file_path)
  end

  it 'prompts for a file path' do
    allow(input).to receive(:gets).and_return(file_path, new_words)
    allow_any_instance_of(FillFile).to receive(:call).and_call_original

    update_file.call
    output.rewind

    expect(output.read).to include I18n.t(:enter_edit_path)
  end

  it 'outputs an error message if the file does not exist' do
    allow(input).to receive(:gets).and_return('non_existent_file.txt')

    update_file.call
    output.rewind

    expect(output.read).to include I18n.t(:file_not_found)
  end

  it 'appends words to the file if it exists' do
    allow(input).to receive(:gets).and_return(file_path, new_words)
    allow_any_instance_of(FillFile).to receive(:call).and_call_original

    update_file.call
    output.rewind

    expect(output.read).to include I18n.t(:words_appended)
    expect(File.read(file_path)).to include file_content

    new_words.split(',').each do |word|
      expect(File.read(file_path)).to include word.strip
    end
  end
end
