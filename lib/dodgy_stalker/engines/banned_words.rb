module DodgyStalker
  module Engines
    class BannedWords
      def initialize(input)
        @input = input
      end

      def banned
        @banned ||= source.banned.match(input).map(&:word)
      end

      def on_hold
        @hold ||= source.on_hold.match(input).map(&:word)
      end

      def notify
        @notify ||= source.to_notify.match(input).map(&:word)
      end

      def blacklisted_email
        @blacklisted_email ||= source.email.match(input, true).map(&:word)
      end

      def to_a(with_partials=false)
        @to_a ||= source.match(input, with_partials).map(&:word)
      end

      def to_words(with_partials=false)
        @to_words ||= source.match(input, with_partials)
      end

      private

      def input
        @input
      end

      def source
        DataStore::Wordlist.new
      end
    end
  end
end
