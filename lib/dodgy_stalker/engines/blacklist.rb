module DodgyStalker
  module Engines
    class Blacklist
      def initialize(attributes)
        @attributes = attributes
      end

      def banned_ip?(ip)
        DataStore::Blacklist.where(ip_address: ip).exists?
      end

      def on_blacklist?
        return false if whitelist.on_list(attributes).exists?

        Policy.new(fetched_results).validate
      end

      def blacklist!(opts={})
        if (blacklist.add(attributes.merge(opts)) && whitelist.remove(attributes))
          true
        else
          false
        end
      end

      #Remove attributes from blacklist and add to whitelist
      def remove!
        if (blacklist.remove(attributes) && whitelist.add(attributes))
          true
        else
          false
        end
      end

      private

      def fetched_results
        @fetched_results ||= blacklist.on_list(attributes).to_a
      end

      def blacklist
        DataStore::Blacklist.new
      end

      def whitelist
        DataStore::Whitelist.new
      end

      def attributes
        @attributes
      end
    end
  end
end
