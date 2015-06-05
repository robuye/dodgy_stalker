require 'spec_helper'

describe DodgyStalker::Policy do
  let(:spamcheck_results) { [double('Result'), double('Result')] }
  let(:policy) { described_class.new(spamcheck_results) }

  describe "#validate" do
    it "returns true if there are any blacklist results" do
      expect(policy.validate).to eq(true)
    end

    it "returns false if there are no blacklist entries" do
      allow(policy).to receive(:spamcheck_results) { [] }
      expect(policy.validate).to eq(false)
    end
  end
end
