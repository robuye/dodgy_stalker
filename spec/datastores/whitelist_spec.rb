require 'spec_helper'

describe DodgyStalker::DataStore::Whitelist do
  let(:list) { described_class.new }
  let(:user) { double('User', email: 'rob@example.com', username: 'rob') }
  let(:attributes) { { email: user.email, username: user.username } }

  describe "#on_list" do
    it "returns only exact matches" do
      list.add(username: user.username)
      list.add(email: user.email)
      list.add(attributes)

      list.on_list(attributes).should have(1).entry

      list.on_list(username: user.username, email: 'mail@domain.com').should have(0).entries
    end
  end

  describe "#add" do
    it "adds new entry to whitelist" do
      expect { list.add(attributes) }.to change { DodgyStalker::DataStore::Whitelist.count }.
        from(0).to(1)
    end

    it "does not add duplicates" do
      list.add(attributes)
      expect { list.add(attributes) }.to_not change { DodgyStalker::DataStore::Whitelist.count }
    end
  end

  describe "#remove" do
    it "removes user from whitelist" do
      list.add(attributes)
      expect { list.remove(attributes) }.to change { DodgyStalker::DataStore::Whitelist.count }.
        from(1).to(0)
    end

    it "removes only exact matches" do
      list.add(attributes.merge(facebook_uid: '123'))
      expect { list.remove(attributes) }.to_not change { DodgyStalker::DataStore::Whitelist.count }
    end
  end
end
