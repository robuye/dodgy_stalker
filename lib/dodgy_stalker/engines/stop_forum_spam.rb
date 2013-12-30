module DodgyStalker
  module Engines
    class StopForumSpam
      def initialize(attributes)
        @attributes = attributes
      end

      def on_blacklist?
        confidence_for(:username) > 0.75 || confidence_for(:email) > 0.75
      end

      private

      def confidence_for(key)
        response[key.to_s]['confidence'].to_f
      rescue #if anything goes wrong do not crash
        0.0
      end

      def query_stopforumspam
        Typhoeus.get(url)
      end

      def response
        @response ||= JSON.parse(query_stopforumspam)
      end

      def url
        base = 'http://www.stopforumspam.com/api'
        uri = Addressable::URI.parse(base)
        uri.query_values = attributes.merge({f: 'json'})
        uri.to_s
      end

      def attributes
        @attributes.select {|k,v| [:username, :email].include?(k)}
      end
    end
  end
end
