require 'pry'
require 'spec_helper'

describe DodgyStalker::Engines::StopForumSpam do
  let(:engine) { described_class.new(attributes) }
  let(:attributes) { { username: 'amilesqexaxdy5478', email: 'robyyy@egamok.tgory.pl' } }

  context "when user is in sfs database" do
    it "returns true confidence is above 0.75" do
      engine.stub(:confidence_for).and_return(0.76)
      engine.on_blacklist?.should be true
    end

    it "returns false when confidence is below 0.75" do
      engine.stub(:confidence_for).and_return(0.74)
      engine.on_blacklist?.should be false
    end
  end
end
