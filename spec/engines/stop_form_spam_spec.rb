require 'pry'
require 'spec_helper'

describe DodgyStalker::Engines::StopForumSpam do
  let(:engine) { described_class.new(attributes) }
  let(:attributes) { { username: 'amilesqexaxdy5478', email: 'robyyy@egamok.tgory.pl' } }

  context "when user is in sfs database" do
    it "returns true confidence is above 0.75" do
      allow(engine).to receive(:confidence_for) { 0.76 }
      expect(engine.on_blacklist?).to eq(true)
    end

    it "returns false when confidence is below 0.75" do
      allow(engine).to receive(:confidence_for) { 0.74 }
      expect(engine.on_blacklist?).to eq(false)
    end
  end
end
