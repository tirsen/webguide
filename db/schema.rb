# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110331041803) do

  create_table "features", :force => true do |t|
    t.string  "name"
    t.string  "triposo_id"
    t.string  "type"
    t.string  "poicat"
    t.string  "poitype"
    t.float   "lat"
    t.float   "lng"
    t.float   "score"
    t.text    "html"
    t.integer "first_zoom_level"
  end

  add_index "features", ["first_zoom_level"], :name => "index_features_on_first_zoom_level"
  add_index "features", ["lat"], :name => "index_features_on_lat"
  add_index "features", ["lng"], :name => "index_features_on_lng"
  add_index "features", ["score"], :name => "index_features_on_score"
  add_index "features", ["triposo_id"], :name => "index_features_on_triposo_id", :unique => true

end
