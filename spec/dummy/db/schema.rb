# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151227072414) do

  create_table "rich_rich_files", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rich_file_file_name"
    t.string   "rich_file_content_type"
    t.integer  "rich_file_file_size"
    t.datetime "rich_file_updated_at"
    t.string   "owner_type"
    t.integer  "owner_id"
    t.text     "uri_cache"
    t.string   "simplified_type",        default: "file"
  end

  create_table "unique_keys", force: :cascade do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "view_path",     null: false
    t.string   "name",          null: false
    t.integer  "position",      null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "unique_keys", ["viewable_type", "view_path", "name", "position", "locale"], name: "index_unique_keys_on_unique_key", unique: true
  add_index "unique_keys", ["viewable_type", "viewable_id"], name: "index_unique_keys_on_viewable_type_and_viewable_id"

  create_table "viewable_links", force: :cascade do |t|
    t.string   "title"
    t.text     "link"
    t.text     "page"
    t.boolean  "target_blank", default: false
    t.boolean  "turbolink",    default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "viewable_texts", force: :cascade do |t|
    t.string   "title"
    t.text     "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
