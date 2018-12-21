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

ActiveRecord::Schema.define(version: 2018_12_20_060300) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircraft_registries", force: :cascade do |t|
    t.string "aircraft_name"
    t.integer "max_seat"
    t.integer "max_cabin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "loads", force: :cascade do |t|
    t.integer "seat_number"
    t.string "specific_cabin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "memo_id"
    t.index ["memo_id"], name: "index_loads_on_memo_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "aircraft_registry_id"
    t.string "flight_number"
    t.date "flight_date"
    t.date "international_flight_date"
    t.datetime "monitoring_update"
    t.text "route"
    t.integer "std"
    t.integer "sta"
    t.integer "frequency"
    t.time "tow_in"
    t.time "tow_out"
    t.time "block_in"
    t.time "cockpit_crew_boarding"
    t.time "cabin_crew_boarding"
    t.time "general_boarding"
    t.time "cargo_boarding"
    t.string "aircraft_status"
    t.string "cabin_crew_availablity"
    t.text "weather_condition"
    t.text "purpose"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "flight_monitoring"
    t.string "aircraft_on_ground"
    t.string "status"
    t.string "aircraft_inoperative"
    t.string "seat_block"
    t.string "no_avi"
    t.text "restriction"
    t.string "airconditioning"
    t.string "aircraft_type"
    t.integer "aircraft_configuration"
    t.index ["aircraft_registry_id"], name: "index_memos_on_aircraft_registry_id"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "page_actions", force: :cascade do |t|
    t.string "description"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_page_actions_on_status_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_departments", force: :cascade do |t|
    t.string "description"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.index ["status_id"], name: "index_user_departments_on_status_id"
  end

  create_table "user_page_actions", force: :cascade do |t|
    t.bigint "user_id"
    t.string "page_actions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_page_actions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.bigint "user_department_id"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_users_on_status_id"
    t.index ["user_department_id"], name: "index_users_on_user_department_id"
  end

  add_foreign_key "loads", "memos"
  add_foreign_key "memos", "aircraft_registries"
  add_foreign_key "memos", "users"
  add_foreign_key "page_actions", "statuses"
  add_foreign_key "user_departments", "statuses"
  add_foreign_key "user_page_actions", "users"
  add_foreign_key "users", "statuses"
  add_foreign_key "users", "user_departments"
end
