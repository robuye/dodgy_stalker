require 'spec_helper'

describe DodgyStalker::Engines::Blacklist do
  let(:engine) { described_class.new(attributes) }
  let(:user)   { double('User', username: 'rob', email: 'rob@example.com') }
  let(:attributes) { { email: user.email, username: user.username } }

  describe "#on_blacklist?" do
    context "when there is no whitelist entry" do
      it "returns true when user is on blacklist" do
        DodgyStalker::DataStore::Blacklist.new.add(attributes)
        engine.on_blacklist?.should be true
      end

      it "returns false when user is not on blacklist" do
        engine.on_blacklist?.should be false
      end
    end

    it "returns false when there is whitelist entry" do
      DodgyStalker::DataStore::Whitelist.new.add(attributes)
      DodgyStalker::DataStore::Blacklist.new.add(attributes)
      engine.on_blacklist?.should be false
    end
  end

  describe "#blacklist!" do
    it "adds user to blacklist" do
      expect { engine.blacklist! }.to change { DodgyStalker::DataStore::Blacklist.count }.
        from(0).to(1)
    end

    it "removes user from whitelist" do
      DodgyStalker::DataStore::Whitelist.new.add(attributes)
      expect { engine.blacklist! }.to change { DodgyStalker::DataStore::Whitelist.count }.
        from(1).to(0)
    end
  end


  describe "#remove!" do
    it "removes the user from blacklist" do
      DodgyStalker::DataStore::Blacklist.new.add(attributes)
      expect { engine.remove! }.to change { DodgyStalker::DataStore::Blacklist.count }.
        from(1).to(0)
    end

    it "adds the user to whitelist" do
      expect { engine.remove! }.to change { DodgyStalker::DataStore::Whitelist.count }.
        from(0).to(1)
    end
  end
end
