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

ActiveRecord::Schema.define(version: 20160111102816) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "equipment", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "reps"
    t.integer  "part_id"
    t.integer  "mode_id"
    t.integer  "equipment_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "items", ["equipment_id"], name: "index_items_on_equipment_id", using: :btree
  add_index "items", ["mode_id"], name: "index_items_on_mode_id", using: :btree
  add_index "items", ["part_id"], name: "index_items_on_part_id", using: :btree

  create_table "lines", force: :cascade do |t|
    t.integer  "page_id"
    t.integer  "no"
    t.integer  "item_id"
    t.integer  "mode_id"
    t.decimal  "weight_1"
    t.decimal  "reps_1"
    t.string   "memo_1"
    t.decimal  "weight_2"
    t.decimal  "reps_2"
    t.string   "memo_2"
    t.decimal  "weight_3"
    t.decimal  "reps_3"
    t.string   "memo_3"
    t.decimal  "weight_4"
    t.decimal  "reps_4"
    t.string   "memo_4"
    t.decimal  "weight_5"
    t.decimal  "reps_5"
    t.string   "memo_5"
    t.decimal  "weight_6"
    t.decimal  "reps_6"
    t.string   "memo_6"
    t.decimal  "weight_7"
    t.decimal  "reps_7"
    t.string   "memo_7"
    t.decimal  "weight_8"
    t.decimal  "reps_8"
    t.string   "memo_8"
    t.decimal  "weight_9"
    t.decimal  "reps_9"
    t.string   "memo_9"
    t.decimal  "weight_0"
    t.decimal  "reps_0"
    t.string   "memo_0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lines", ["item_id"], name: "index_lines_on_item_id", using: :btree
  add_index "lines", ["mode_id"], name: "index_lines_on_mode_id", using: :btree
  add_index "lines", ["page_id"], name: "index_lines_on_page_id", using: :btree

  create_table "modes", force: :cascade do |t|
    t.string   "name"
    t.string   "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.date     "date"
    t.string   "place"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "memo"
    t.binary   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "parts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trainings", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "weight"
    t.integer  "reps"
    t.integer  "set"
    t.integer  "mode_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "day"
    t.integer  "num"
  end

  add_index "trainings", ["item_id"], name: "index_trainings_on_item_id", using: :btree
  add_index "trainings", ["mode_id"], name: "index_trainings_on_mode_id", using: :btree

  add_foreign_key "items", "equipment"
  add_foreign_key "items", "modes"
  add_foreign_key "items", "parts"
  add_foreign_key "lines", "items"
  add_foreign_key "lines", "modes"
  add_foreign_key "lines", "pages"
  add_foreign_key "trainings", "items"
  add_foreign_key "trainings", "modes"
end
