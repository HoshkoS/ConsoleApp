require_relative '../translation'

RSpec.describe Translation do
  class DummyClass
    include Translation
  end

  let(:dummy_instance) { DummyClass.new }

  before do
    I18n.backend.store_translations(:en, {
      hello: 'Hello, world!',
      greeting: 'Hello, %{name}!'
    })
  end

  describe "#translate" do
    it "prints the result" do
      path = :hello
      expected_output = 'Hello, world!'

      expect { dummy_instance.translate(path) }.to output("#{expected_output}\n").to_stdout
    end

    it "prints the result with interpolation" do
      path = :greeting
      values = { name: 'John' }
      expected_output = 'Hello, John!'

      expect { dummy_instance.translate(path, **values) }.to output("#{expected_output}\n").to_stdout
    end
  end
end
