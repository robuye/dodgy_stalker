module DodgyStalker
  module DataStore
    module Common
      def on_list(attributes)
        model.where(attributes_conditions(attributes))
      end

      def add(attributes)
        model.where(attributes).first_or_create
      end

      def remove(attr)
        conditions = attributes.with_indifferent_access.except(:id, :created_at, :updated_at).merge(attr)
        model.where(conditions).delete_all
      end

      private

      #Build OR query from non-empty attributes
      def attributes_conditions(attributes)
        attributes.reject {|k,v| v.nil?}.
          map {|attribute, value| arel_table[attribute].eq(value) }.
          inject(:or)
      end

      def arel_table
        model.arel_table
      end

      def model
        self.class
      end
    end
  end
end
