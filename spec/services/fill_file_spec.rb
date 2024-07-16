require_relative '../../services/fill_file'

RSpec.describe FillFile do
  let(:test_path) { 'test_file.txt' }
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }

  before do
    $stdin = input
    $stdout = output
  end

  after do
    $stdin = STDIN
    $stdout = STDOUT

    File.delete(test_path) if File.exist?(test_path)
  end

  it 'appends words to the file' do
    allow(input).to receive(:gets).and_return('apple, banana, cherry')
    allow(subject).to receive(:translate).with(:enter_words)
    allow(subject).to receive(:translate).with(:invalid_words)

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['apple', 'banana', 'cherry'])
  end

  it 'strips leading and trailing spaces from words' do
    allow(input).to receive(:gets).and_return('  apple  ,  banana ,  cherry  ')
    allow(subject).to receive(:translate).with(:enter_words)
    allow(subject).to receive(:translate).with(:invalid_words)

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['apple', 'banana', 'cherry'])
  end

  it 'does not overwrite existing file content' do
    File.open(test_path, 'w') { |file| file.puts 'existing line' }
    allow(input).to receive(:gets).and_return('apple, banana')
    allow(subject).to receive(:translate).with(:enter_words)
    allow(subject).to receive(:translate).with(:invalid_words)

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['existing line', 'apple', 'banana'])
  end

  it 'prompts again if input is invalid' do
    allow(input).to receive(:gets).and_return('apple, 123', 'banana, cherry')
    expect(subject).to receive(:translate).with(:enter_words).twice
    expect(subject).to receive(:translate).with(:invalid_words).once

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['banana', 'cherry'])
  end
end
