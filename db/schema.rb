# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_04_27_190239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.integer "admin_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "users_id", null: false
    t.index ["users_id"], name: "index_admins_on_users_id"
  end

  create_table "brandings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "events_id", null: false
    t.index ["events_id"], name: "index_brandings_on_events_id"
  end

  create_table "calls", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_calls_on_event_id"
    t.index ["user_id"], name: "index_calls_on_user_id"
  end

  create_table "checkpoint_times", force: :cascade do |t|
    t.datetime "times"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "participant_id", null: false
    t.bigint "checkpoint_id", null: false
    t.index ["checkpoint_id"], name: "index_checkpoint_times_on_checkpoint_id"
    t.index ["participant_id"], name: "index_checkpoint_times_on_participant_id"
  end

  create_table "checkpoints", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "os_grid"
    t.bigint "events_id", null: false
    t.index ["events_id"], name: "index_checkpoints_on_events_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "marshalls", force: :cascade do |t|
    t.integer "marshal_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "checkpoints_id", null: false
    t.bigint "users_id", null: false
    t.index ["checkpoints_id"], name: "index_marshalls_on_checkpoints_id"
    t.index ["users_id"], name: "index_marshalls_on_users_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "participant_id"
    t.string "pace"
    t.datetime "arrival_time"
    t.integer "rank"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "checkpoints_id", null: false
    t.bigint "routes_id", null: false
    t.boolean "opted_in_leaderboard", default: false, null: false
    t.bigint "user_id", null: false
    t.index ["checkpoints_id"], name: "index_participants_on_checkpoints_id"
    t.index ["routes_id"], name: "index_participants_on_routes_id"
  end

  create_table "pickups", force: :cascade do |t|
    t.string "os_grid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_pickups_on_event_id"
    t.index ["user_id"], name: "index_pickups_on_user_id"
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.date "start_date"
    t.time "start_time"
    t.integer "course_length"
    t.bigint "events_id", null: false
    t.datetime "end_date_time"
    t.index ["events_id"], name: "index_routes_on_events_id"
  end

  create_table "routes_and_checkpoints_linkers", force: :cascade do |t|
    t.float "distance_from_start"
    t.string "checkpoint_description"
    t.integer "advised_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "route_id", null: false
    t.bigint "checkpoint_id", null: false
    t.integer "position_in_route"
    t.index ["checkpoint_id"], name: "index_routes_and_checkpoints_linkers_on_checkpoint_id"
    t.index ["route_id"], name: "index_routes_and_checkpoints_linkers_on_route_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cas_ticket"
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tag_id", null: false
    t.index ["tag_id", "user_id"], name: "index_tags_users_on_tag_id_and_user_id"
    t.index ["user_id", "tag_id"], name: "index_tags_users_on_user_id_and_tag_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "description"
    t.string "mobile"
    t.string "membership_id"
    t.bigint "tag_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["tag_id"], name: "index_users_on_tag_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "users", column: "users_id"
  add_foreign_key "brandings", "events", column: "events_id"
  add_foreign_key "calls", "events"
  add_foreign_key "calls", "users"
  add_foreign_key "checkpoint_times", "checkpoints"
  add_foreign_key "checkpoint_times", "participants"
  add_foreign_key "checkpoints", "events", column: "events_id"
  add_foreign_key "marshalls", "checkpoints", column: "checkpoints_id"
  add_foreign_key "marshalls", "users", column: "users_id"
  add_foreign_key "participants", "checkpoints", column: "checkpoints_id"
  add_foreign_key "participants", "routes", column: "routes_id"
  add_foreign_key "pickups", "events"
  add_foreign_key "pickups", "users"
  add_foreign_key "routes", "events", column: "events_id"
  add_foreign_key "routes_and_checkpoints_linkers", "checkpoints"
  add_foreign_key "routes_and_checkpoints_linkers", "routes"
  add_foreign_key "users", "tags"
end
