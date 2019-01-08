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

ActiveRecord::Schema.define(version: 2019_01_07_145431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aircraft_types", force: :cascade do |t|
    t.string "ac_type"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_aircraft_types_on_status_id"
  end

  create_table "categories", force: :cascade do |t|
    t.text "category"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_categories_on_status_id"
  end

  create_table "frequencies", force: :cascade do |t|
    t.string "frequency"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_frequencies_on_status_id"
  end

  create_table "locations", force: :cascade do |t|
    t.text "location"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_locations_on_status_id"
  end

  create_table "memo_categories", force: :cascade do |t|
    t.bigint "memo_id"
    t.time "tow_out"
    t.time "tow_in"
    t.time "blocked_in"
    t.string "ac_registry"
    t.time "cockpit_crew_boarded"
    t.time "cabin_crew_boarded"
    t.time "general_boarding"
    t.time "baggage_cargo_loaded"
    t.time "close_door"
    t.time "push_back"
    t.time "air_bourne"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.date "effective_date"
    t.string "flight_number"
    t.string "apu_inoperative"
    t.string "seat_blocks"
    t.string "no_avi"
    t.string "restriction"
    t.string "acu_problem"
    t.string "ac_on_ground"
    t.integer "load_b"
    t.integer "load_p"
    t.integer "load_e"
    t.datetime "ac_status_datetime"
    t.string "location"
    t.string "movement"
    t.string "max_wind"
    t.string "weather_forecast"
    t.string "route_origin"
    t.string "route_destination"
    t.string "ac_location"
    t.date "flight_date"
    t.bigint "aircraft_type_id"
    t.string "ac_configuration"
    t.time "std"
    t.time "sta"
    t.bigint "frequency_id"
    t.time "nstd"
    t.time "nsta"
    t.index ["aircraft_type_id"], name: "index_memo_categories_on_aircraft_type_id"
    t.index ["category_id"], name: "index_memo_categories_on_category_id"
    t.index ["frequency_id"], name: "index_memo_categories_on_frequency_id"
    t.index ["memo_id"], name: "index_memo_categories_on_memo_id"
  end

  create_table "memos", force: :cascade do |t|
    t.string "recipients", default: [], array: true
    t.string "incoordinate_with", default: [], array: true
    t.string "reasons", default: [], array: true
    t.string "remarks", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.datetime "time_and_date"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "page_actions", force: :cascade do |t|
    t.string "description"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_page_actions_on_status_id"
  end

  create_table "reasons", force: :cascade do |t|
    t.text "reason"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_reasons_on_status_id"
  end

  create_table "remarks", force: :cascade do |t|
    t.text "remark"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_remarks_on_status_id"
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

  add_foreign_key "aircraft_types", "statuses"
  add_foreign_key "categories", "statuses"
  add_foreign_key "frequencies", "statuses"
  add_foreign_key "locations", "statuses"
  add_foreign_key "memo_categories", "aircraft_types"
  add_foreign_key "memo_categories", "categories"
  add_foreign_key "memo_categories", "frequencies"
  add_foreign_key "memo_categories", "memos"
  add_foreign_key "memos", "users"
  add_foreign_key "page_actions", "statuses"
  add_foreign_key "reasons", "statuses"
  add_foreign_key "remarks", "statuses"
  add_foreign_key "user_departments", "statuses"
  add_foreign_key "user_page_actions", "users"
  add_foreign_key "users", "statuses"
  add_foreign_key "users", "user_departments"
end
