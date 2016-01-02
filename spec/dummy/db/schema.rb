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

ActiveRecord::Schema.define(version: 20160102010317) do

  create_table "form_fields", force: :cascade do |t|
    t.integer  "structure_id"
    t.integer  "position"
    t.string   "type"
    t.boolean  "required",     default: false
    t.string   "label_en"
    t.string   "label_fr"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "form_fields", ["structure_id"], name: "index_form_fields_on_structure_id"

  create_table "form_jobs", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "country"
    t.text     "periods"
    t.string   "letter_file_name"
    t.string   "letter_content_type"
    t.integer  "letter_file_size"
    t.datetime "letter_updated_at"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "form_rows", force: :cascade do |t|
    t.integer  "structure_id"
    t.text     "column_0"
    t.text     "column_1"
    t.text     "column_2"
    t.text     "column_3"
    t.text     "column_4"
    t.text     "column_5"
    t.text     "column_6"
    t.text     "column_7"
    t.text     "column_8"
    t.text     "column_9"
    t.text     "column_10"
    t.text     "column_11"
    t.text     "column_12"
    t.text     "column_13"
    t.text     "column_14"
    t.text     "column_15"
    t.text     "column_16"
    t.text     "column_17"
    t.text     "column_18"
    t.text     "column_19"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "form_rows", ["structure_id"], name: "index_form_rows_on_structure_id"

  create_table "form_structures", force: :cascade do |t|
    t.boolean  "send_email",      default: false
    t.string   "send_to"
    t.string   "send_subject_en"
    t.string   "send_subject_fr"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

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

  create_table "settings", force: :cascade do |t|
    t.string   "name"
    t.text     "value"
    t.string   "unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "settings", ["name"], name: "index_settings_on_name", unique: true

  create_table "unique_keys", force: :cascade do |t|
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.text     "view_path",     null: false
    t.text     "name",          null: false
    t.integer  "position",      null: false
    t.string   "locale",        null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "unique_keys", ["viewable_type", "view_path", "name", "position", "locale"], name: "index_unique_keys_on_unique_key", unique: true
  add_index "unique_keys", ["viewable_type", "viewable_id"], name: "index_unique_keys_on_viewable_type_and_viewable_id"

  create_table "viewable_blocks", force: :cascade do |t|
    t.string   "uuid"
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "viewable_forms", force: :cascade do |t|
    t.integer  "structure_id"
    t.string   "uuid"
    t.text     "url"
    t.string   "title"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "viewable_forms", ["structure_id"], name: "index_viewable_forms_on_structure_id"
  add_index "viewable_forms", ["url"], name: "index_viewable_forms_on_url"

  create_table "viewable_images", force: :cascade do |t|
    t.string   "title"
    t.text     "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "viewable_links", force: :cascade do |t|
    t.string   "title"
    t.text     "url"
    t.text     "page"
    t.text     "file"
    t.boolean  "target_blank", default: false
    t.boolean  "turbolink",    default: true
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "viewable_pages", force: :cascade do |t|
    t.string   "uuid"
    t.text     "url"
    t.string   "title"
    t.text     "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "viewable_pages", ["url"], name: "index_viewable_pages_on_url"

  create_table "viewable_selects", force: :cascade do |t|
    t.string   "value"
    t.string   "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "viewable_texts", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
