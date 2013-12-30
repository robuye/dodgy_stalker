require 'spec_helper'

describe DodgyStalker::Policy do
  let(:spamcheck_results) { [double('Result'), double('Result')] }
  let(:policy) { described_class.new(spamcheck_results) }

  describe "#validate" do
    it "returns true if there are any blacklist results" do
      policy.validate.should be true
    end

    it "returns false if there are no blacklist entries" do
      policy.stub(:spamcheck_results).and_return([])
      policy.validate.should be false
    end
  end
end
