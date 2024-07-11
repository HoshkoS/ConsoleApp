require_relative '../../services/fill_file'

RSpec.describe FillFile do
  let(:test_path) { 'test_file.txt' }

  after do
    File.delete(test_path) if File.exist?(test_path)
  end

  it 'appends words to the file' do
    allow(subject).to receive(:gets).and_return('apple, banana, cherry')

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['apple', 'banana', 'cherry'])
  end

  it 'strips leading and trailing spaces from words' do
    allow(subject).to receive(:gets).and_return('  apple  ,  banana ,  cherry  ')

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['apple', 'banana', 'cherry'])
  end

  it 'does not overwrite existing file content' do
    File.open(test_path, 'w') { |file| file.puts 'existing line' }
    allow(subject).to receive(:gets).and_return('apple, banana')

    subject.call(test_path)
    file_content = File.read(test_path).split("\n")

    expect(file_content).to eq(['existing line', 'apple', 'banana'])
  end
end
