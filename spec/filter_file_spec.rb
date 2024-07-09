require_relative '../services/filter_file'

RSpec.describe FilterFile do
  let(:filter_file) { FilterFile.new }
  let(:input_file) { 'test_input.csv' }
  let(:output_dir) { 'new_files' }
  let(:filtered_file) { "#{output_dir}/test_input_filtered.csv" }

  before do
    CSV.open(input_file, 'w') do |csv|
      csv << ['hello world', 'this is a test']
      csv << ['foo bar', 'baz qux']
    end

    FileUtils.mkdir_p(output_dir)

    I18n.backend.store_translations(:en, {
      file_not_found: 'File not found.',
      filtering_complete: 'Filtering complete.',
      words_filtered: 'Words filtered - %{count}'
    })
    I18n.locale = :en

    allow(filter_file).to receive(:sleep).and_return(nil)
  end

  after do
    File.delete(input_file) if File.exist?(input_file)
    FileUtils.rm_rf(output_dir) if Dir.exist?(output_dir)
  end

  it 'filters words in the file and creates a new file' do
    allow(filter_file).to receive(:gets).and_return(input_file, 'hello, foo')

    expect { filter_file.call }.to output(/Filtering complete./).to_stdout

    expect(File).to exist(filtered_file)
    filtered_content = CSV.read(filtered_file)
    expect(filtered_content).to eq([['* world', 'this is a test'], ['* bar', 'baz qux']])
  end

  it 'prints an error if the file does not exist' do
    allow(filter_file).to receive(:gets).and_return('non_existent.csv')

    expect { filter_file.call }.to output(/File not found./).to_stdout
  end

  it 'prints the number of filtered words' do
    allow(filter_file).to receive(:gets).and_return(input_file, 'hello, foo')

    expect { filter_file.call }.to output(/Words filtered - 2/).to_stdout
  end
end
