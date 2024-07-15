require_relative '../../services/null_action'

RSpec.describe NullAction do

  it "calls exit with the default wait_time" do
    expect(subject).to receive(:exit)
    subject.call
  end

  it "calls exit with a specified wait_time" do
    expect(subject).to receive(:exit)
    subject.call(5)
  end
end
