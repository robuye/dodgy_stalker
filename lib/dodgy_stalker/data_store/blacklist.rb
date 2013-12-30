module DodgyStalker
  module DataStore
    class Blacklist < ActiveRecord::Base
      self.table_name = 'blacklist'

      include Common
    end
  end
end
