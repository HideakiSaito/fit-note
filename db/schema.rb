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

ActiveRecord::Schema.define(version: 20160616130126) do

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

  create_table "conditions", force: :cascade do |t|
    t.string   "name"
    t.float    "score"
    t.string   "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diets", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "equipment", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "feelings", force: :cascade do |t|
    t.string   "name"
    t.float    "score"
    t.string   "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_categories", force: :cascade do |t|
    t.string   "name"
    t.integer  "no"
    t.integer  "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "foods", force: :cascade do |t|
    t.string   "name"
    t.integer  "diet_id"
    t.float    "calorie"
    t.float    "carbohydrate"
    t.float    "fat"
    t.float    "protein"
    t.float    "vegetable"
    t.string   "diet_memo"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "food_category_id"
    t.string   "sort_key"
  end

  add_index "foods", ["diet_id"], name: "index_foods_on_diet_id", using: :btree
  add_index "foods", ["food_category_id"], name: "index_foods_on_food_category_id", using: :btree

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

  create_table "page_images", force: :cascade do |t|
    t.integer  "page_id"
    t.binary   "data"
    t.string   "content_type"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "page_images", ["page_id"], name: "index_page_images_on_page_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.date     "date"
    t.string   "place"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "memo"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "diet_id"
    t.float    "carbohydrate_1"
    t.float    "fat_1"
    t.float    "protein_1"
    t.float    "vegetable_1"
    t.string   "diet_memo_1"
    t.float    "carbohydrate_2"
    t.float    "fat_2"
    t.float    "protein_2"
    t.float    "vegetable_2"
    t.string   "diet_memo_2"
    t.float    "carbohydrate_3"
    t.float    "fat_3"
    t.float    "protein_3"
    t.float    "vegetable_3"
    t.string   "diet_memo_3"
    t.float    "carbohydrate_4"
    t.float    "fat_4"
    t.float    "protein_4"
    t.float    "vegetable_4"
    t.string   "diet_memo_4"
    t.float    "carbohydrate_5"
    t.float    "fat_5"
    t.float    "protein_5"
    t.float    "vegetable_5"
    t.string   "diet_memo_5"
    t.integer  "condition_id"
    t.integer  "feeling_id"
    t.float    "sleep_hour"
    t.time     "sleep_time"
    t.float    "water"
    t.float    "alcohol"
    t.float    "caffeine"
    t.float    "wight"
    t.float    "work_hour"
    t.float    "study_hour"
    t.float    "tv_hour"
    t.float    "training_hour"
    t.float    "body_fat_per"
    t.float    "body_size_neck"
    t.float    "body_size_bust"
    t.float    "body_size_waist"
    t.float    "body_size_hip"
    t.float    "body_size_arm_right"
    t.float    "body_size_arm_left"
    t.float    "body_size_leg_right"
    t.float    "body_size_leg_left"
    t.float    "body_size_calf_right"
    t.float    "body_size_calf_left"
  end

  add_index "pages", ["condition_id"], name: "index_pages_on_condition_id", using: :btree
  add_index "pages", ["diet_id"], name: "index_pages_on_diet_id", using: :btree
  add_index "pages", ["feeling_id"], name: "index_pages_on_feeling_id", using: :btree

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

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "email"
    t.string   "icon"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "hashed_password"
  end

  add_foreign_key "foods", "diets"
  add_foreign_key "foods", "food_categories"
  add_foreign_key "items", "equipment"
  add_foreign_key "items", "modes"
  add_foreign_key "items", "parts"
  add_foreign_key "lines", "items"
  add_foreign_key "lines", "modes"
  add_foreign_key "lines", "pages"
  add_foreign_key "page_images", "pages"
  add_foreign_key "pages", "conditions"
  add_foreign_key "pages", "diets"
  add_foreign_key "pages", "feelings"
  add_foreign_key "trainings", "items"
  add_foreign_key "trainings", "modes"
end
