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

ActiveRecord::Schema.define(version: 2019_08_28_201046) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "house_committees", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.string "chair"
    t.bigint "representative_id"
    t.string "url"
    t.string "subcommittees"
    t.string "chamber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["representative_id"], name: "index_house_committees_on_representative_id"
  end

  create_table "joint_committees", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.string "chair"
    t.bigint "representative_id"
    t.string "url"
    t.string "chamber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["representative_id"], name: "index_joint_committees_on_representative_id"
  end

  create_table "representatives", force: :cascade do |t|
    t.string "propublica_id"
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "gender"
    t.string "chamber"
    t.string "party"
    t.string "new_york_times_url"
    t.string "contact_form"
    t.string "phone"
    t.string "dc_office"
    t.string "twitter_id"
    t.string "facebook_account"
    t.string "seniority"
    t.string "next_election"
    t.string "district"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_representatives_on_state_id"
  end

  create_table "saved_representatives", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "representative_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["representative_id"], name: "index_saved_representatives_on_representative_id"
    t.index ["user_id"], name: "index_saved_representatives_on_user_id"
  end

  create_table "saved_senators", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "senator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senator_id"], name: "index_saved_senators_on_senator_id"
    t.index ["user_id"], name: "index_saved_senators_on_user_id"
  end

  create_table "senate_committees", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.string "chair"
    t.bigint "senator_id"
    t.string "url"
    t.string "subcommittees"
    t.string "chamber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senator_id"], name: "index_senate_committees_on_senator_id"
  end

  create_table "senators", force: :cascade do |t|
    t.string "propublica_id"
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "role"
    t.string "gender"
    t.string "chamber"
    t.string "party"
    t.string "new_york_times_url"
    t.string "contact_form"
    t.string "phone"
    t.string "dc_office"
    t.string "twitter_id"
    t.string "facebook_account"
    t.string "seniority"
    t.string "next_election"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_senators_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "abbreviation"
    t.string "name"
    t.float "voter_turnout"
    t.boolean "twenty_nineteen_election"
    t.date "twenty_nineteen_election_date"
    t.string "twenty_nineteen_election_type"
    t.string "twenty_nineteen_election_scope"
    t.boolean "twenty_twenty_election"
    t.date "twenty_twenty_democratic_primary_date"
    t.string "dem_primary_type"
    t.date "twenty_twenty_republican_primary_date"
    t.string "rep_primary_type"
    t.date "twenty_twenty_general_election_date"
    t.string "id_required"
    t.boolean "early_or_in_person_absentee_voting"
    t.string "early_or_in_person_absentee_voting_begins"
    t.string "early_or_in_person_absentee_voting_ends"
    t.boolean "automatic_voter_registration"
    t.boolean "same_day_voter_registration"
    t.boolean "online_voter_registration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.string "user_state"
    t.bigint "state_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  add_foreign_key "house_committees", "representatives"
  add_foreign_key "joint_committees", "representatives"
  add_foreign_key "representatives", "states"
  add_foreign_key "saved_representatives", "representatives"
  add_foreign_key "saved_representatives", "users"
  add_foreign_key "saved_senators", "senators"
  add_foreign_key "saved_senators", "users"
  add_foreign_key "senate_committees", "senators"
  add_foreign_key "senators", "states"
  add_foreign_key "users", "states"
end
