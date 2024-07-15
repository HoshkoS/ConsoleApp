require_relative '../../services/abstract_service'

RSpec.describe AbstractService do
  describe "#call" do
    it "raises NotImplemented error when not defined in subclass" do
      expect { subject.call }.to raise_error(NotImplementedError)
    end
  end

  describe "#check_file_presence" do
    let(:file_path) { 'path/to/file' }

    context "when file exists" do
      before do
        allow(File).to receive(:exist?).with(file_path).and_return(true)
      end

      it "returns the file path" do
        expect(subject.send(:check_file_presence, file_path)).to eq(file_path)
      end
    end

    context "when file does not exist" do
      before do
        allow(File).to receive(:exist?).with(file_path).and_return(false)
        allow(subject).to receive(:translate).with(:file_not_found)
      end

      it "calls translate with :file_not_found" do
        expect(subject).to receive(:translate).with(:file_not_found)
        subject.send(:check_file_presence, file_path)
      end

      it "returns nil" do
        expect(subject.send(:check_file_presence, file_path)).to be_nil
      end
    end
  end
end
