require_relative '../services/read_file'

RSpec.describe ReadFile do
  let(:read_file) { ReadFile.new }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:file_path) { 'test_file.txt' }
  let(:file_content) { 'This is a test file content.' }

  before do
    $stdin = input
    $stdout = output

    allow(input).to receive(:gets).and_return(file_path)
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT
    File.delete(file_path) if File.exist?(file_path)
  end

  before(:each) do
    read_file.call
    output.rewind
  end

  it 'prompts for a file path' do
    expect(output.read).to include I18n.t(:enter_path)
  end

  it 'outputs an error message if the file does not exist' do
    expect(output.read).to include I18n.t(:file_not_found)
  end

  it 'reads and outputs the file content if the file exists' do
    File.open(file_path, 'a') do |file|
      file.puts 'This is a test file content.'
    end

    read_file.call
    output.rewind

    expect(output.read).to include file_content
  end
end
