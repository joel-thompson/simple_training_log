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

ActiveRecord::Schema.define(version: 20181201171646) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "body_weight_records", force: :cascade do |t|
    t.float    "weight"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "weighed_at"
    t.datetime "expired_at"
    t.index ["user_id"], name: "index_body_weight_records_on_user_id", using: :btree
  end

  create_table "cardio_choices", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_cardio_choices_on_user_id_and_name", unique: true, using: :btree
    t.index ["user_id"], name: "index_cardio_choices_on_user_id", using: :btree
  end

  create_table "cardios", force: :cascade do |t|
    t.integer  "cardio_choice_id"
    t.integer  "duration_in_seconds"
    t.text     "notes"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.date     "occurred_date"
    t.string   "occurred_time"
    t.index ["cardio_choice_id"], name: "index_cardios_on_cardio_choice_id", using: :btree
  end

  create_table "lift_choices", force: :cascade do |t|
    t.integer  "default_sets"
    t.integer  "default_reps"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.boolean  "has_weight"
    t.integer  "user_id"
    t.string   "name"
    t.index ["user_id", "name"], name: "index_lift_choices_on_user_id_and_name", unique: true, using: :btree
    t.index ["user_id"], name: "index_lift_choices_on_user_id", using: :btree
  end

  create_table "lifts", force: :cascade do |t|
    t.integer  "lift_choice_id"
    t.float    "weight"
    t.integer  "sets"
    t.integer  "reps"
    t.date     "occurred_date"
    t.string   "occurred_time"
    t.string   "location"
    t.text     "notes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "last_amrap_set"
    t.index ["lift_choice_id"], name: "index_lifts_on_lift_choice_id", using: :btree
  end

  create_table "martial_arts", force: :cascade do |t|
    t.string   "type"
    t.text     "notes"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "user_id"
    t.integer  "duration_in_seconds"
    t.date     "occurred_date"
    t.string   "occurred_time"
    t.text     "goal"
    t.text     "goal_result"
    t.string   "location"
    t.index ["user_id"], name: "index_martial_arts_on_user_id", using: :btree
  end

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
    t.index ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at", using: :btree
    t.index ["user_id"], name: "index_microposts_on_user_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.string   "partner_name"
    t.integer  "submissions"
    t.text     "notes"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "martial_art_id"
    t.index ["martial_art_id"], name: "index_rounds_on_martial_art_id", using: :btree
  end

  create_table "techniques", force: :cascade do |t|
    t.string   "name"
    t.text     "details"
    t.text     "notes"
    t.integer  "martial_art_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["martial_art_id"], name: "index_techniques_on_martial_art_id", using: :btree
  end

  create_table "training_programs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "notes"
    t.datetime "activated_at"
    t.datetime "deactivated_at"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "schedule"
    t.index ["user_id"], name: "index_training_programs_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "body_weight_records", "users"
  add_foreign_key "cardio_choices", "users"
  add_foreign_key "cardios", "cardio_choices"
  add_foreign_key "lift_choices", "users"
  add_foreign_key "lifts", "lift_choices"
  add_foreign_key "martial_arts", "users"
  add_foreign_key "microposts", "users"
  add_foreign_key "rounds", "martial_arts"
  add_foreign_key "techniques", "martial_arts"
  add_foreign_key "training_programs", "users"
end
