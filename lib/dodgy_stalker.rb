require "dodgy_stalker/version"

require "typhoeus"
require "json"
require "active_record"

require "dodgy_stalker/data_store"
require "dodgy_stalker/engines"
require "dodgy_stalker/policy"

module DodgyStalker
  def self.disable!
    @disabled = true
  end

  def self.enable!
    @disabled = false
  end

  def self.disabled
    @disabled
  end
end
