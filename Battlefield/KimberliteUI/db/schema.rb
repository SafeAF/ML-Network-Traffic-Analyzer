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

ActiveRecord::Schema.define(version: 20130925004729) do

  create_table "bans", force: true do |t|
    t.string   "ip"
    t.integer  "duration"
    t.string   "gucid"
    t.string   "instance_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "host_lookup", default: "UNKNOWN"
    t.string   "location",    default: "UNKNOWN"
    t.text     "reason"
  end

  create_table "confs", force: true do |t|
    t.integer "ban_duration",      default: 3888000
    t.integer "invalid_weight",    default: 45
    t.integer "failed_weight",     default: 10
    t.integer "sensitivity",       default: 100
    t.string  "log_location",      default: "/var/log/auth.log"
    t.string  "denyfile_location", default: "/etc/hosts.deny"
    t.string  "error_log",         default: "/var/log/emergence/error.log"
    t.integer "delay",             default: 60
    t.integer "retry",             default: 60
    t.string  "instance_id"
    t.text    "pcap_location"
    t.text    "pcap_filter"
    t.text    "pcap_interface"
    t.integer "update_flag",       default: 0
    t.boolean "stats_log?"
    t.boolean "stats_pcap?"
    t.boolean "monitor_log?"
    t.boolean "monitor_pcap?"
  end

  create_table "instances", force: true do |t|
    t.string   "instance_type"
    t.string   "gucid"
    t.string   "hostname"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribed",    default: false, null: false
    t.boolean  "installed",     default: false, null: false
    t.datetime "alive"
    t.string   "description"
    t.string   "human_name"
    t.integer  "machine_id"
    t.boolean  "aggregation",   default: false
  end

  create_table "machines", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.string   "cid",       default: "none"
    t.string   "ip"
    t.string   "hostname"
    t.boolean  "installed", default: false
    t.datetime "alive"
  end

  create_table "messages", force: true do |t|
    t.integer "instance_id"
    t.string  "message"
  end

  create_table "rights", force: true do |t|
    t.string "name"
    t.string "controller"
    t.string "action"
  end

  create_table "rights_roles", id: false, force: true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", force: true do |t|
    t.string "name"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "salt"
    t.string   "name"
    t.string   "fullname"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country"
    t.string   "company"
  end

end
