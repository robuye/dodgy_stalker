class CreateDodgyStalkerTables < ActiveRecord::Migration
  def change
     create_table "wordlist", force: true do |t| 
       t.string   "word"
       t.boolean  "ban"
       t.boolean  "notify"
       t.boolean  "hold"
       t.string   "regexp_word"
       t.boolean  "blacklist_email", default: false
       t.datetime "created_at",                      null: false
       t.datetime "updated_at",                      null: false
     end
  end
end
