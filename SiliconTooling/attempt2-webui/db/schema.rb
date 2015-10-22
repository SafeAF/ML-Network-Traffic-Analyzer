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

ActiveRecord::Schema.define(version: 20150903032741) do

  create_table "audittrails", force: :cascade do |t|
    t.integer  "logofusers_id", limit: 4
    t.string   "username",      limit: 255
    t.string   "description",   limit: 255
    t.text     "audit_trail",   limit: 65535
    t.boolean  "sudo?"
    t.boolean  "su?"
    t.datetime "occurred_at"
    t.string   "filename",      limit: 255
    t.string   "machine",       limit: 255
    t.string   "command",       limit: 255
    t.integer  "occurances",    limit: 65535
    t.integer  "failures",      limit: 65535
    t.integer  "successes",     limit: 65535
    t.integer  "returncode",    limit: 65535
    t.boolean  "succeeded?"
    t.string   "log_location",  limit: 255
    t.boolean  "logged?"
  end

  create_table "bans", force: :cascade do |t|
    t.string   "ip",                       limit: 255
    t.string   "srcip",                    limit: 255
    t.string   "srcport",                  limit: 255
    t.string   "destip",                   limit: 255
    t.string   "protocol",                 limit: 255
    t.string   "service",                  limit: 255
    t.string   "cid",                      limit: 255
    t.string   "user",                     limit: 255
    t.string   "geo",                      limit: 255
    t.integer  "reputation",               limit: 65535
    t.integer  "change_in_reputation",     limit: 65535
    t.integer  "prev_reputation",          limit: 65535
    t.boolean  "externally_known_bad?"
    t.string   "other_source",             limit: 255
    t.string   "other_source2",            limit: 255
    t.integer  "other_source_reputation",  limit: 65535
    t.integer  "otehr_source2_reputation", limit: 65535
    t.float    "rep",                      limit: 65535
    t.string   "priority",                 limit: 255
    t.string   "facility",                 limit: 255
    t.boolean  "from_pcap?",                             default: false
    t.datetime "occurred_at"
    t.datetime "last_seen"
    t.datetime "first_seen"
    t.boolean  "valid_reverse_lookup"
    t.datetime "last_validated"
    t.string   "source_file_path",         limit: 255
    t.string   "client_hostname",          limit: 255
    t.integer  "duration",                 limit: 65535
    t.string   "gucid",                    limit: 255
    t.integer  "machine_id",               limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "host_lookup",              limit: 255,   default: "UNKNOWN"
    t.string   "location",                 limit: 255,   default: "UNKNOWN"
    t.text     "reason",                   limit: 65535
    t.string   "extrastring",              limit: 255
    t.boolean  "extraboolean?"
    t.text     "extratext",                limit: 65535
    t.integer  "extrainteger",             limit: 4
    t.float    "extrafloat",               limit: 24
    t.string   "botnet_membership",        limit: 255
    t.string   "isp",                      limit: 255
  end

  create_table "cluster", force: :cascade do |t|
    t.integer "user_id",      limit: 4
    t.string  "name",         limit: 255
    t.string  "cluster_type", limit: 255
    t.integer "members",      limit: 4
  end

  create_table "confs", force: :cascade do |t|
    t.integer "ban_duration",      limit: 4,     default: 3888000
    t.integer "invalid_weight",    limit: 4,     default: 45
    t.integer "failed_weight",     limit: 4,     default: 10
    t.integer "sensitivity",       limit: 4,     default: 100
    t.string  "log_location",      limit: 255,   default: "/var/log/auth.log"
    t.string  "denyfile_location", limit: 255,   default: "/etc/hosts.deny"
    t.string  "error_log",         limit: 255,   default: "/var/log/emergence/error.log"
    t.integer "delay",             limit: 4,     default: 60
    t.integer "retry",             limit: 4,     default: 60
    t.string  "instance_id",       limit: 255
    t.text    "pcap_location",     limit: 65535
    t.text    "pcap_filter",       limit: 65535
    t.text    "pcap_interface",    limit: 65535
    t.integer "update_flag",       limit: 4,     default: 0
    t.boolean "stats_log?"
    t.boolean "stats_pcap?"
    t.boolean "monitor_log?"
    t.boolean "monitor_pcap?"
    t.text    "instance_info",     limit: 65535
    t.integer "extrainteger",      limit: 4
    t.boolean "extraboolean?"
    t.string  "extrastring",       limit: 255
    t.text    "extratext",         limit: 65535
  end

  create_table "connections", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.string  "program",     limit: 255
    t.string  "status",      limit: 255
    t.boolean "open?",                   default: false
    t.string  "protocol",    limit: 255
    t.integer "proto",       limit: 4
    t.string  "srcip",       limit: 255
    t.string  "destip",      limit: 255
    t.string  "srcport",     limit: 255
    t.string  "dstport",     limit: 255
    t.boolean "listener?",               default: false
    t.integer "pid",         limit: 4
    t.integer "recv",        limit: 4
    t.integer "sent",        limit: 4
    t.integer "machine_id",  limit: 4
  end

  create_table "dashboards", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "cluster",         limit: 255
    t.string   "description",     limit: 255
    t.string   "manager",         limit: 255
    t.string   "manager_address", limit: 255
    t.integer  "hosts_total",     limit: 4
    t.integer  "nodes_total",     limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "harddrives", force: :cascade do |t|
    t.string  "name",         limit: 255
    t.string  "description",  limit: 255
    t.string  "mount_point",  limit: 255
    t.string  "device",       limit: 255
    t.string  "UUID",         limit: 255
    t.float   "available",    limit: 24
    t.float   "size",         limit: 24
    t.float   "used",         limit: 24
    t.float   "percent_used", limit: 24
    t.string  "filesystem",   limit: 255
    t.integer "machine_id",   limit: 4
  end

  create_table "instances", force: :cascade do |t|
    t.string   "instance_type",  limit: 255
    t.string   "gucid",          limit: 255
    t.string   "hostname",       limit: 255
    t.string   "facility",       limit: 255
    t.string   "extended_stats", limit: 255
    t.string   "ip",             limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "subscribed",                   default: false, null: false
    t.boolean  "installed",                    default: false, null: false
    t.datetime "alive"
    t.string   "description",    limit: 255
    t.string   "human_name",     limit: 255
    t.integer  "machine_id",     limit: 4
    t.boolean  "aggregation",                  default: false
    t.integer  "extrainteger",   limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",    limit: 255
    t.text     "extratext",      limit: 65535
    t.float    "extrafloat",     limit: 24
  end

  create_table "items", force: :cascade do |t|
    t.integer "quantity", limit: 4
    t.string  "name",     limit: 255
    t.string  "desc",     limit: 255
    t.string  "value",    limit: 255
    t.float   "quan",     limit: 24
  end

  create_table "logentries", force: :cascade do |t|
    t.integer  "logfile_id",  limit: 4
    t.string   "name",        limit: 255
    t.text     "message",     limit: 65535
    t.string   "facility",    limit: 255
    t.integer  "priority",    limit: 4
    t.datetime "logged_at"
    t.string   "service",     limit: 255
    t.integer  "logentry_id", limit: 4
  end

  create_table "logfiles", force: :cascade do |t|
    t.integer "machine_id",  limit: 4
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.float   "size",        limit: 24
    t.integer "entries",     limit: 4
    t.string  "location",    limit: 255
    t.string  "path",        limit: 255
    t.string  "basename",    limit: 255
    t.string  "service",     limit: 255
  end

  create_table "logofusers", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "description", limit: 255
    t.datetime "lastlog"
    t.boolean  "loggedin?"
    t.integer  "sessions",    limit: 4
    t.integer  "gid",         limit: 4
    t.boolean  "sudo?"
    t.integer  "machine_id",  limit: 4
  end

  create_table "machines", force: :cascade do |t|
    t.string   "name",                         limit: 255
    t.string   "executor",                     limit: 255
    t.string   "remote_execution",             limit: 255
    t.boolean  "remote_execution_capability?"
    t.integer  "user_id",                      limit: 4
    t.integer  "cluster_id",                   limit: 4
    t.string   "cid",                          limit: 255,   default: "none"
    t.string   "ip",                           limit: 255
    t.string   "hostname",                     limit: 255
    t.string   "physical_host",                limit: 255
    t.string   "is_virtual?",                  limit: 255,   default: "1"
    t.integer  "ram",                          limit: 4
    t.integer  "cpus",                         limit: 4
    t.string   "cputype",                      limit: 255
    t.integer  "ipaddr",                       limit: 4
    t.integer  "ram_available",                limit: 4
    t.integer  "ram_cached",                   limit: 4
    t.integer  "ram_buffers",                  limit: 4
    t.integer  "ram_swap",                     limit: 4
    t.float    "load1m",                       limit: 24
    t.float    "load5m",                       limit: 24
    t.float    "load15m",                      limit: 24
    t.integer  "disk_total",                   limit: 4
    t.integer  "disk_avail",                   limit: 4
    t.integer  "disk_used",                    limit: 4
    t.integer  "listeners",                    limit: 4
    t.integer  "established",                  limit: 4
    t.text     "network_connections",          limit: 65535
    t.string   "node_name",                    limit: 255
    t.string   "cluster",                      limit: 255
    t.boolean  "installed",                                  default: false
    t.datetime "alive"
    t.string   "status",                       limit: 255
    t.integer  "health",                       limit: 4
    t.integer  "extrainteger",                 limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",                  limit: 255
    t.text     "extratext",                    limit: 65535
    t.float    "extrafloat",                   limit: 24
  end

  create_table "messages", force: :cascade do |t|
    t.integer "instance_id", limit: 4
    t.string  "message",     limit: 255
  end

  create_table "nodes", force: :cascade do |t|
    t.string  "name",       limit: 255
    t.integer "server_id",  limit: 4
    t.string  "hostname",   limit: 255
    t.string  "ip",         limit: 255
    t.integer "ipaddr",     limit: 4
    t.integer "machine_id", limit: 4
    t.string  "value",      limit: 255
    t.float   "quantity",   limit: 24
    t.integer "number",     limit: 4
  end

  create_table "procs", force: :cascade do |t|
    t.string  "name",       limit: 255
    t.integer "pid",        limit: 4
    t.string  "process",    limit: 255
    t.string  "path",       limit: 255
    t.float   "proctime",   limit: 24
    t.integer "machine_id", limit: 4
    t.integer "server_id",  limit: 4
    t.integer "node_id",    limit: 4
  end

  create_table "rights", force: :cascade do |t|
    t.string "name",       limit: 255
    t.string "controller", limit: 255
    t.string "action",     limit: 255
  end

  create_table "rights_roles", id: false, force: :cascade do |t|
    t.integer "right_id", limit: 4
    t.integer "role_id",  limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4
    t.integer "user_id", limit: 4
  end

  create_table "servers", force: :cascade do |t|
    t.string  "name",       limit: 255
    t.string  "username",   limit: 255
    t.string  "password",   limit: 255
    t.text    "privkey",    limit: 65535
    t.text    "pubkey",     limit: 65535
    t.text    "key",        limit: 65535
    t.string  "ip",         limit: 255
    t.string  "hostname",   limit: 255
    t.string  "cluster",    limit: 255
    t.integer "ipaddr",     limit: 4
    t.string  "type",       limit: 255
    t.integer "machine_id", limit: 4
    t.integer "cluster_id", limit: 4
    t.boolean "up"
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "simple_captcha_data", force: :cascade do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statistics", force: :cascade do |t|
    t.integer "machine_id",     limit: 4
    t.string  "name",           limit: 255
    t.string  "description",    limit: 255
    t.string  "value",          limit: 255
    t.boolean "active?"
    t.integer "quantity",       limit: 4
    t.float   "rateofchange",   limit: 24
    t.float   "current_value",  limit: 24
    t.float   "previous_value", limit: 24
    t.float   "percentage",     limit: 24
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           limit: 255
    t.string   "hashed_password", limit: 255
    t.string   "key",             limit: 255
    t.string   "salt",            limit: 255
    t.string   "name",            limit: 255
    t.string   "fullname",        limit: 255
    t.string   "username",        limit: 255
    t.string   "address1",        limit: 255
    t.string   "address2",        limit: 255
    t.string   "city",            limit: 255
    t.string   "state",           limit: 255
    t.string   "zip",             limit: 255
    t.string   "phone",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "country",         limit: 255
    t.string   "company",         limit: 255
  end

end
