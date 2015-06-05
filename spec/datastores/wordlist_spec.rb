require 'spec_helper'

describe DodgyStalker::DataStore::Wordlist do
  let(:wordlist) { described_class.new(word: 'word') }

  describe "#toggle" do
    context "attributes :ban, :hold, :notify" do
      it "toggle one attribute, turn off others" do
        wordlist.toggle('ban')
        expect(wordlist.ban).to eq(true)
        expect(wordlist.hold).to eq(false)
        expect(wordlist.notify).to eq(false)

        wordlist.toggle('hold')
        expect(wordlist.ban).to eq(false)
        expect(wordlist.hold).to eq(true)
        expect(wordlist.notify).to eq(false)
      end
    end
  end
end
