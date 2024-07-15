require_relative '../../services/filter_file'

RSpec.describe FilterFile do
  let(:input_file) { 'test_input.csv' }
  let(:output_dir) { 'new_files' }
  let(:filtered_file) { "#{output_dir}/test_input_filtered.csv" }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before do
    $stdin = input
    $stdout = output

    CSV.open(input_file, 'w') do |csv|
      csv << ['hello world', 'this is a test']
      csv << ['foo bar', 'baz qux']
    end

    FileUtils.mkdir_p(output_dir)

    allow(subject).to receive(:sleep).and_return(nil)
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT

    File.delete(input_file) if File.exist?(input_file)
    FileUtils.rm_rf(output_dir) if Dir.exist?(output_dir)
  end

  it 'filters words in the file and creates a new file' do
    allow(input).to receive(:gets).and_return(input_file, 'hello, foo')

    subject.call
    output.rewind

    expect(output.read).to include I18n.t(:filtering_complete)
    expect(File).to exist(filtered_file)
    filtered_content = CSV.read(filtered_file)
    expect(filtered_content).to eq([['* world', 'this is a test'], ['* bar', 'baz qux']])
  end

  it 'prints an error if the file does not exist' do
    allow(input).to receive(:gets).and_return('non_existent.csv')

    subject.call
    output.rewind

    expect(output.read).to include I18n.t(:file_not_found)
  end

  it 'prints the number of filtered words' do
    allow(input).to receive(:gets).and_return(input_file, 'hello, foo')

    subject.call
    output.rewind

    expect(output.read).to include I18n.t(:words_filtered, count: 2)
  end
end
