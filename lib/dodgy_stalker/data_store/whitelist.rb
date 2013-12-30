module DodgyStalker
  module DataStore
    class Whitelist < ActiveRecord::Base
      self.table_name = 'whitelist'

      include Common

      def on_list(attr)
        conditions = attributes.with_indifferent_access.except(:id, :created_at, :updated_at).merge(attr)
        model.where(conditions)
      end
    end
  end
end
