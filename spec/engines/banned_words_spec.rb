require 'spec_helper'

describe DodgyStalker::Engines::BannedWords do
  let(:engine)     { described_class.new(input) }
  let(:input)      { "fuck! 'quoted' +plused+ ass underage viagra" }
  let(:datastore)  { DodgyStalker::DataStore::Wordlist }

  describe "#banned" do
    it "returns a list of banned words in input" do
      datastore.create(word: 'fuck!', ban: true)
      datastore.create(word: 'ass', ban: true)
      engine.banned.should =~ ['fuck!', 'ass']
    end
  end

  describe "#blacklisted_email" do
    it "returns a list of blacklisted emails" do
      datastore.create(word: '@wp.pl', blacklist_email: true)
      described_class.new('piotr@wp.pl').blacklisted_email.should =~ ['@wp.pl']
    end
  end

  describe "#on_hold" do
    it "returns a list of hold words in input" do
      datastore.create(word: 'viagra', hold: true)
      engine.on_hold.should =~ ['viagra']
    end
  end

  describe "#notify" do
    it "returns a list of notify words in input" do
      datastore.create(word: 'underage', notify: true)
      engine.notify.should =~ ['underage']
    end
  end

  describe "#match" do
    it "matches full words (no partials)" do
      datastore.create(word: 'fuck', ban: true)
      engine.banned.should be_empty
    end

    it "ignores quotes on matches" do
      datastore.create(word: 'quoted', ban: true)
      engine.banned.to_a.should have(1).word
    end

    it "allows to change word separator via config" do
      old_separator = DodgyStalker::Config.new.word_separator
      DodgyStalker.configure {|c| c.word_separator = %q{(^|\s|\A|\Z|$|\.|,|\+)} }
      datastore.create(word: 'plused', ban: true)
      engine.banned.to_a.should have(1).word
      DodgyStalker.configure {|c| c.word_separator = old_separator }
    end

    it "matches with partials" do
      datastore.create(word: 'fuck', ban: true)
      engine.to_a(true).should have(1).element
    end
  end
end
