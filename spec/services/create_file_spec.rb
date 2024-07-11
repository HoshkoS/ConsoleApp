require_relative '../../services/create_file'
require_relative '../../services/fill_file'

RSpec.describe CreateFile do
  let(:fill_file_double) { instance_double(FillFile) }
  let(:filename) { 'test_file' }
  let(:file_path) { "new_files/#{filename}.txt" }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before do
    $stdin = input
    $stdout = output

    FileUtils.rm_rf('new_files')

    allow(input).to receive(:gets).and_return(filename)
    allow(FillFile).to receive(:new).and_return(fill_file_double)
    allow(fill_file_double).to receive(:call).with(file_path)
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT
    FileUtils.rm_rf('new_files')
  end

  it 'creates a new file if it does not exist' do
    subject.call
    output.rewind

    expect(output.read).to include I18n.t(:file_created)
    expect(File).to exist(file_path)
  end

  it 'does not overwrite an existing file' do
    FileUtils.mkdir_p('new_files')
    FileUtils.touch(file_path)

    subject.call
    output.rewind

    expect(output.read).to include I18n.t(:file_exists)
  end

  it 'creates the new_files directory if it does not exist' do
    subject.call

    expect(Dir).to exist('new_files')
  end
end
