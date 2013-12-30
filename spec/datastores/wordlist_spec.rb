require 'spec_helper'

describe DodgyStalker::DataStore::Wordlist do
  let(:wordlist) { described_class.new(word: 'word') }

  describe "#toggle" do
    context "attributes :ban, :hold, :notify" do
      it "toggle one attribute, turn off others" do
        wordlist.toggle('ban')
        wordlist.ban.should be true
        wordlist.hold.should be false
        wordlist.notify.should be false

        wordlist.toggle('hold')
        wordlist.ban.should be false
        wordlist.hold.should be true
        wordlist.notify.should be false
      end
    end
  end
end
