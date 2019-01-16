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

ActiveRecord::Schema.define(version: 2019_01_15_162146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advisories", force: :cascade do |t|
    t.string "recipients", default: [], array: true
    t.string "incoordinate_with", default: [], array: true
    t.bigint "user_id"
    t.string "sid"
    t.boolean "is_viewable", default: false
    t.datetime "sent_date"
    t.string "advisory_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_advisories_on_user_id"
  end

  create_table "advisory_categories", force: :cascade do |t|
    t.string "ac_configuration"
    t.string "ac_location"
    t.string "ac_on_ground"
    t.string "ac_registry"
    t.datetime "ac_status_datetime"
    t.string "acu_problem"
    t.time "air_bourne"
    t.bigint "aircraft_type_id"
    t.string "apu_inoperative"
    t.time "baggage_cargo_loaded"
    t.time "blocked_in"
    t.time "cabin_crew_boarded"
    t.bigint "category_id"
    t.time "close_door"
    t.time "cockpit_crew_boarded"
    t.date "effective_date"
    t.date "flight_date"
    t.string "flight_number"
    t.string "frequencies", default: [], array: true
    t.time "general_boarding"
    t.integer "load_b"
    t.integer "load_e"
    t.integer "load_p"
    t.string "location"
    t.string "max_wind"
    t.string "movement"
    t.string "no_avi"
    t.time "nsta"
    t.time "nstd"
    t.time "push_back"
    t.text "remarks"
    t.string "restriction"
    t.string "route_destination"
    t.string "route_origin"
    t.string "seat_blocks"
    t.time "sta"
    t.time "std"
    t.time "tow_in"
    t.time "tow_out"
    t.string "weather_forecast"
    t.string "arrival_terminal"
    t.string "departure_terminal"
    t.time "duration_of_delay"
    t.time "eta"
    t.time "etd"
    t.time "neta"
    t.time "netd"
    t.string "pax"
    t.bigint "advisory_reason_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisory_reason_id"], name: "index_advisory_categories_on_advisory_reason_id"
    t.index ["aircraft_type_id"], name: "index_advisory_categories_on_aircraft_type_id"
    t.index ["category_id"], name: "index_advisory_categories_on_category_id"
  end

  create_table "advisory_reasons", force: :cascade do |t|
    t.string "reasons", default: [], array: true
    t.string "remarks", default: [], array: true
    t.datetime "time_and_date"
    t.bigint "advisory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisory_id"], name: "index_advisory_reasons_on_advisory_id"
  end

  create_table "advisory_relations", force: :cascade do |t|
    t.integer "dept_advisory"
    t.integer "occ_advisory"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_advisory_relations_on_user_id"
  end

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

  create_table "inboxes", force: :cascade do |t|
    t.integer "recipient"
    t.integer "sender"
    t.bigint "advisory_id"
    t.boolean "is_read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority"
    t.index ["advisory_id"], name: "index_inboxes_on_advisory_id"
  end

  create_table "locations", force: :cascade do |t|
    t.text "location"
    t.bigint "status_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status_id"], name: "index_locations_on_status_id"
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

  create_table "reply_threads", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id"
    t.bigint "advisory_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["advisory_id"], name: "index_reply_threads_on_advisory_id"
    t.index ["user_id"], name: "index_reply_threads_on_user_id"
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

  add_foreign_key "advisories", "users"
  add_foreign_key "advisory_categories", "advisory_reasons"
  add_foreign_key "advisory_categories", "aircraft_types"
  add_foreign_key "advisory_categories", "categories"
  add_foreign_key "advisory_reasons", "advisories"
  add_foreign_key "advisory_relations", "users"
  add_foreign_key "aircraft_types", "statuses"
  add_foreign_key "categories", "statuses"
  add_foreign_key "frequencies", "statuses"
  add_foreign_key "inboxes", "advisories"
  add_foreign_key "locations", "statuses"
  add_foreign_key "page_actions", "statuses"
  add_foreign_key "reasons", "statuses"
  add_foreign_key "remarks", "statuses"
  add_foreign_key "reply_threads", "advisories"
  add_foreign_key "reply_threads", "users"
  add_foreign_key "user_departments", "statuses"
  add_foreign_key "user_page_actions", "users"
  add_foreign_key "users", "statuses"
  add_foreign_key "users", "user_departments"
end
