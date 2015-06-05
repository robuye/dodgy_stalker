require 'spec_helper'

describe DodgyStalker::Engines::BannedWords do
  let(:engine)     { described_class.new(input) }
  let(:input)      { "fuck! 'quoted' +plused+ ass underage viagra" }
  let(:datastore)  { DodgyStalker::DataStore::Wordlist }

  describe "#banned" do
    it "returns a list of banned words in input" do
      datastore.create(word: 'fuck!', ban: true)
      datastore.create(word: 'ass', ban: true)
      expect(engine.banned).to include('fuck!', 'ass')
    end
  end

  describe "#blacklisted_email" do
    it "returns a list of blacklisted emails" do
      datastore.create(word: '@wp.pl', blacklist_email: true)
      engine = described_class.new('piotr@wp.pl')
      expect(engine.blacklisted_email).to include('@wp.pl')
    end
  end

  describe "#on_hold" do
    it "returns a list of hold words in input" do
      datastore.create(word: 'viagra', hold: true)
      expect(engine.on_hold).to include('viagra')
    end
  end

  describe "#notify" do
    it "returns a list of notify words in input" do
      datastore.create(word: 'underage', notify: true)
      expect(engine.notify).to include('underage')
    end
  end

  describe "#match" do
    it "matches full words (no partials)" do
      datastore.create(word: 'fuck', ban: true)
      expect(engine.banned.size).to eq(0)
    end

    it "ignores quotes on matches" do
      datastore.create(word: 'quoted', ban: true)
      expect(engine.banned.to_a.size).to eq(1)
    end

    it "allows to change word separator via config" do
      old_separator = DodgyStalker::Config.new.word_separator
      DodgyStalker.configure {|c| c.word_separator = %q{(^|\s|\A|\Z|$|\.|,|\+)} }
      datastore.create(word: 'plused', ban: true)
      expect(engine.banned.to_a.size). to eq(1)
      DodgyStalker.configure {|c| c.word_separator = old_separator }
    end

    it "matches with partials" do
      datastore.create(word: 'fuck', ban: true)
      expect(engine.to_a(true).size).to eq(1)
    end
  end
end
