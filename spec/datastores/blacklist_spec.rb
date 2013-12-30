require 'spec_helper'

describe DodgyStalker::DataStore::Blacklist do
  let(:list) { described_class.new }
  let(:user) { double('User', username: 'Rob', email: 'email@domain.com') }
  let(:attributes) { { email: user.email, username: user.username } }

  describe "#on_list" do
    it "returns matches for any attributes" do
      list.add(username: user.username)
      list.add(email: user.email)
      list.on_list(attributes).should have(2).entries
    end
  end

  describe "#add" do
    it "adds new entry to blacklist" do
      expect { list.add(attributes) }.to change { DodgyStalker::DataStore::Blacklist.count }.
        from(0).to(1)
    end

    it "does not add duplicates" do
      list.add(attributes)
      expect { list.add(attributes) }.to_not change { DodgyStalker::DataStore::Blacklist.count }
    end
  end

  describe "#remove" do
    it "removes user from blacklist" do
      list.add(attributes)
      expect { list.remove(attributes) }.to change { DodgyStalker::DataStore::Blacklist.count }.
        from(1).to(0)
    end

    it "removes only exact matches" do
      list.add(attributes.merge(facebook_uid: '123'))
      expect { list.remove(attributes) }.to_not change { DodgyStalker::DataStore::Blacklist.count }
    end
  end
end
