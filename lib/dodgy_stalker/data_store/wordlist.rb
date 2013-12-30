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
        @banned = model.where(ban: true)
        self
      end

      def on_hold
        @on_hold = model.where(hold: true)
        self
      end

      def to_notify
        @to_notify = model.where(notify: true)
        self
      end

      def email
        @email = model.where(blacklist_email: true)
        self
      end

      def match(input, partials_match=false)
        if partials_match
          model.where("? ~* regexp_word", input)
        else
          model.where("? ~* ('#{word_separator}' || regexp_word || '#{word_separator}')", input)
        end
      end

      private

      def regexscape_word
        self.regexp_word = Regexp.escape(word)
      end

      def word_separator
        '(^|\s|\A|\Z|$|\.|,)'
      end

      def model
        @model ||= self.class
      end
    end
  end
end
