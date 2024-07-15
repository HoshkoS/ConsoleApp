require_relative '../file_factory'

RSpec.describe FileFactory do
  describe ".call" do
    context "when action_name is :read" do
      it "returns an instance of ReadFile and calls #call" do
        allow_any_instance_of(ReadFile).to receive(:call).and_return("Reading file")
        expect(FileFactory.call(:read)).to eq("Reading file")
      end
    end

    context "when action_name is :create" do
      it "returns an instance of CreateFile and calls #call" do
        allow_any_instance_of(CreateFile).to receive(:call).and_return("Creating file")
        expect(FileFactory.call(:create)).to eq("Creating file")
      end
    end

    context "when action_name is :update" do
      it "returns an instance of UpdateFile and calls #call" do
        allow_any_instance_of(UpdateFile).to receive(:call).and_return("Updating file")
        expect(FileFactory.call(:update)).to eq("Updating file")
      end
    end

    context "when action_name is :filter" do
      it "returns an instance of FilterFile and calls #call" do
        allow_any_instance_of(FilterFile).to receive(:call).and_return("Filtering file")
        expect(FileFactory.call(:filter)).to eq("Filtering file")
      end
    end

    context "when action_name is unknown" do
      it "returns an instance of NullAction and calls #call" do
        allow_any_instance_of(NullAction).to receive(:call).and_return("No action")
        expect(FileFactory.call(:unknown)).to eq("No action")
      end
    end
  end
end
