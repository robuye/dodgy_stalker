module DodgyStalker
  module DataStore
    class Wordlist < ActiveRecord::Base
      self.table_name = 'wordlist'

      before_save :regexscape_word

      DependentAttributes = [
        [:ban, :hold, :notify],
        [:blacklist_email]
      ]

      #Turns off all dependent attributes, toggles the one passed
      def toggle(attribute)
        DependentAttributes.select {|array| array.include?(attribute.to_sym)}.each do |dependencies|
          attributes_for_update = dependencies.each_with_object({}) {|a, memo| memo[a] = false}
          update_attributes(attributes_for_update.merge({attribute.to_sym => !self.read_attribute(attribute)}))
        end
      end

      def banned
        @current = model.where(ban: true)
        self
      end

      def banned?
        !!ban
      end

      def on_hold
        @current = model.where(hold: true)
        self
      end

      def to_notify
        @current = model.where(notify: true)
        self
      end

      def email
        @current = model.where(blacklist_email: true)
        self
      end

      def current
        @current || model
      end

      def match(input, partials_match=false)
        if partials_match
          current.where(":input ~* regexp_word", input: input)
        else
          current.where(":input ~* ('#{word_separator}' || regexp_word || '#{word_separator}')", input: input)
        end
      end

      private

      def regexscape_word
        self.regexp_word = Regexp.escape(word)
      end

      def word_separator
        DodgyStalker.config.word_separator
      end

      def model
        @model ||= self.class
      end
    end
  end
end
