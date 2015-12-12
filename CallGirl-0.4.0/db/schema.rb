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

ActiveRecord::Schema.define(version: 20150925004729) do


  create_table "messagehub", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.integer "criticality"
    t.string "priority"
  end

  create_table "opslists", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.integer "criticality"
    t.string "priority"
  end

  create_table "devopslists", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.integer "criticality"
    t.string "priority"
    t.text "body"
  end

  create_table "corporatememos", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.integer "criticality"
    t.string "priority"
    t.text "body"
  end

  create_table "titanclustermemos", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.integer "criticality"
    t.string "priority"
    t.text "body"
  end

  create_table "memos", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.integer "criticality"
    t.integer :priority
  end
  create_table "encryptedrecords", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.integer "criticality"
    t.text "body"
  end

  create_table "lists", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
  end

  create_table "secretslists", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.string "relevence"
    t.string "lifetime"
    t.integer "user_id"
    t.integer "criticality"
  end
  create_table "seculists", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.string "url"
    t.string "authors"
    t.integer "criticality"
  end

  create_table "vulnerabilities", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.string "owaspid"
    t.string "cve"
    t.integer "cve_id"
    t.text "content"
    t.string "url"
    t.string "discoverer"
    t.integer "criticality"
  end

  create_table "exploits", force: :cascade do |t|
    t.datetime "created_at",
               t.datetime "updated_at",
                          t.string   "name",
                                     t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.text "body"
    t.text "exploit"
    t.string "url"
    t.string "authors"
    t.integer "criticality"
  end


  create_table "machineintellects", force: :cascade do |t|
    t.datetime "created_at",
    t.datetime "updated_at",
    t.string   "name",
               t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.string   "hostname",       limit: 255
    t.float "false_positive_rate"
    t.string   "parent_process", limit: 255
    t.integer  "process_id",     limit: 4
    t.string   "service",        limit: 255
    t.string   "notice",         limit: 255
    t.integer  "node_id",        limit: 4
    t.integer  "criticality",    limit: 4
    t.integer  "priority",       limit: 4
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "network",        limit: 255
    t.integer  "network_id",     limit: 4
    t.integer  "manager_id",     limit: 4
    t.string   "status",         limit: 255
    t.integer  "developer_id",   limit: 4
    t.string "dataset"
    t.text "configuration"
    t.integer "features"
    t.float "false_negative_rate" ; end

  create_table "datasets", force: :cascade do |t|
    t.string "name"
    t.string "purpose"
    t.string "description"
    t.integer "training_set_size"
    t.integer "control_set_size"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "machineintellect_id"
    t.boolean "example?"
  end

  create_table "controldatums", force: :cascade do |t|
    t.string "name"
    t.float "proportion"
    t.integer "quantity"
    t.string "value"
    t.integer "dataset_id"
    t.boolean "example?"
  end
  create_table "trainingdatums", force: :cascade do |t|
    t.string "name"
    t.float "proportion"
    t.integer "quantity"
    t.string "value"
    t.integer "dataset_id"
    t.boolean "example?"
  end

  create_table "admins", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_password",    limit: 255
    t.string   "encrypted_password", limit: 255
    t.string   "key",                limit: 255
    t.string   "workstation",        limit: 255
    t.string   "authorization",      limit: 255
    t.string   "auth_method",        limit: 255
    t.string   "salt",               limit: 255
    t.string   "name",               limit: 255
    t.string   "fullname",           limit: 255
    t.string   "username",           limit: 255
    t.string   "phone",              limit: 255
    t.string   "lastlog_ip",         limit: 255
    t.datetime "lastlog"
    t.boolean  "logged_in?"
    t.string   "country",            limit: 255
    t.string   "company",            limit: 255
    t.integer  "infrastructure_id",  limit: 4
    t.integer  "network_id",         limit: 4
    t.integer  "cluster_id",         limit: 4
    t.string   "pki",                limit: 255
    t.string   "key_type",           limit: 255
    t.integer  "pubkey_id",          limit: 4
    t.integer  "privkey_id",         limit: 4
    t.integer  "group_id",           limit: 4
    t.integer  "access_level",       limit: 4
    t.boolean  "developer?"
    t.boolean  "operator?"
    t.boolean  "appop?"
    t.boolean  "admin?"
    t.integer  "operations_id",      limit: 4
    t.integer  "devops_id",          limit: 4
    t.integer  "developent_id",      limit: 4
    t.integer  "research_id",        limit: 4
    t.string   "job_title",          limit: 255
    t.string   "job_requirements",   limit: 255
    t.boolean  "root?"
    t.integer  "manager_id",         limit: 4
  end

  create_table "applications", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",           limit: 255
    t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.string   "hostname",       limit: 255
    t.string   "parent_process", limit: 255
    t.integer  "process_id",     limit: 4
    t.string   "service",        limit: 255
    t.string   "notice",         limit: 255
    t.integer  "node_id",        limit: 4
    t.integer  "criticality",    limit: 4
    t.integer  "priority",       limit: 4
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "user_id",        limit: 4
    t.string   "network",        limit: 255
    t.integer  "network_id",     limit: 4
    t.integer  "manager_id",     limit: 4
    t.string   "status",         limit: 255
    t.integer  "developer_id",   limit: 4
    t.integer  "pubserver_id",   limit: 4
  end

  create_table "audit_trail_users", force: :cascade do |t|
    t.integer  "userlog_id",      limit: 4
    t.string   "username",        limit: 255
    t.string   "description",     limit: 255
    t.text     "record",          limit: 65535
    t.boolean  "sudo?"
    t.boolean  "su?"
    t.datetime "occurred_at"
    t.string   "filename",        limit: 255
    t.string   "machine",         limit: 255
    t.string   "command",         limit: 255
    t.integer  "occurances",      limit: 4
    t.integer  "failures",        limit: 4
    t.integer  "successes",       limit: 4
    t.integer  "returncode",      limit: 4
    t.boolean  "succeeded?"
    t.string   "log_location",    limit: 255
    t.boolean  "logged?"
    t.integer  "user_id",         limit: 4
    t.integer  "organization_id", limit: 4
    t.integer  "machine_id",      limit: 4
    t.integer  "server_id",       limit: 4
    t.integer  "gid",             limit: 4
  end

  create_table "bans", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ip",                       limit: 255
    t.integer  "ip_id",                    limit: 4
    t.string   "srcip",                    limit: 255
    t.string   "srcport",                  limit: 255
    t.string   "destip",                   limit: 255
    t.string   "protocol",                 limit: 255
    t.string   "service",                  limit: 255
    t.string   "cid",                      limit: 255
    t.string   "user",                     limit: 255
    t.string   "geo",                      limit: 255
    t.integer  "reputation",               limit: 4
    t.integer  "change_in_reputation",     limit: 4
    t.integer  "prev_reputation",          limit: 4
    t.boolean  "externally_known_bad?"
    t.string   "other_source",             limit: 255
    t.string   "other_source2",            limit: 255
    t.integer  "other_source_reputation",  limit: 4
    t.integer  "other_source2_reputation", limit: 4
    t.float    "rep",                      limit: 24
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
    t.integer  "duration",                 limit: 4
    t.string   "gucid",                    limit: 255
    t.integer  "machine_id",               limit: 4
    t.integer  "server_id",                limit: 4
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
    t.string   "network",                  limit: 255
    t.integer  "network_id",               limit: 4
  end

  create_table "clusters", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "user_id",           limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "name",              limit: 255
    t.string   "cluster_type",      limit: 255
    t.integer  "members",           limit: 4
    t.string   "resource_manager",  limit: 255
    t.text     "information",       limit: 65535
    t.string   "status",            limit: 255
    t.text     "details",           limit: 65535
    t.integer  "organization_id",   limit: 4
  end

  create_table "configurations", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",           limit: 255
    t.string   "purpose",        limit: 255
    t.string   "description",    limit: 255
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "application_id", limit: 4
    t.integer  "service_id",     limit: 4
    t.text     "config",         limit: 65535
    t.text     "alt_config",     limit: 65535
    t.string   "version",        limit: 255
    t.string   "var",            limit: 255
    t.string   "var2",           limit: 255
    t.string   "var3",           limit: 255
    t.string   "var4",           limit: 255
    t.string   "var5",           limit: 255
    t.integer  "ivar",           limit: 4
    t.integer  "ivar2",          limit: 4
    t.integer  "ivar3",          limit: 4
    t.float    "fvar",           limit: 24
    t.float    "fvar2",          limit: 24
  end

  create_table "confs", force: :cascade do |t|
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.integer  "ban_duration",      limit: 4,     default: 3888000
    t.integer  "invalid_weight",    limit: 4,     default: 45
    t.integer  "failed_weight",     limit: 4,     default: 10
    t.integer  "sensitivity",       limit: 4,     default: 100
    t.string   "log_location",      limit: 255,   default: "/var/log/auth.log"
    t.string   "denyfile_location", limit: 255,   default: "/etc/hosts.deny"
    t.string   "error_log",         limit: 255,   default: "/var/log/emergence/error.log"
    t.integer  "delay",             limit: 4,     default: 60
    t.integer  "retry",             limit: 4,     default: 60
    t.string   "instance_id",       limit: 255
    t.text     "pcap_location",     limit: 65535
    t.text     "pcap_filter",       limit: 65535
    t.text     "pcap_interface",    limit: 65535
    t.integer  "update_flag",       limit: 4,     default: 0
    t.boolean  "stats_log?"
    t.boolean  "stats_pcap?"
    t.boolean  "monitor_log?"
    t.boolean  "monitor_pcap?"
    t.text     "instance_info",     limit: 65535
    t.integer  "extrainteger",      limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",       limit: 255
    t.text     "extratext",         limit: 65535
  end

  create_table "connections", force: :cascade do |t|
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.string   "program",     limit: 255
    t.string   "status",      limit: 255
    t.boolean  "open?",                   default: false
    t.string   "protocol",    limit: 255
    t.integer  "proto",       limit: 4
    t.string   "srcip",       limit: 255
    t.string   "destip",      limit: 255
    t.string   "srcport",     limit: 255
    t.string   "dstport",     limit: 255
    t.boolean  "listener?",               default: false
    t.integer  "pid",         limit: 4
    t.integer  "recv",        limit: 4
    t.integer  "sent",        limit: 4
    t.integer  "machine_id",  limit: 4
    t.integer  "server_id",   limit: 4
    t.integer  "service_id",  limit: 4
    t.integer  "process_id",  limit: 4
    t.string   "filehandles", limit: 255
    t.integer  "network_id",  limit: 4
  end

  create_table "credits", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "total",           limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "member_id",       limit: 4
    t.integer  "username_id",     limit: 4
    t.integer  "organization_id", limit: 4
  end

  create_table "critlarms", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "name",                 limit: 255
    t.string   "heading",              limit: 255
    t.string   "content",              limit: 255
    t.text     "body",                 limit: 65535
    t.string   "source",               limit: 255
    t.string   "destination",          limit: 255
    t.string   "pos_in_queque",        limit: 255
    t.string   "tied_to_ui_component", limit: 255
    t.integer  "populates_widget",     limit: 4
  end

  create_table "databases", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "hostname",          limit: 255
    t.string   "cluster",           limit: 255
    t.string   "type",              limit: 255
    t.string   "dbserver",          limit: 255
    t.string   "db",                limit: 255
    t.integer  "count",             limit: 4
    t.string   "user",              limit: 255
    t.string   "password",          limit: 255
    t.string   "connection_string", limit: 255
    t.integer  "server_id",         limit: 4
    t.integer  "machine_id",        limit: 4
    t.integer  "cluster_id",        limit: 4
    t.integer  "service_id",        limit: 4
    t.integer  "application_id",    limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "status",            limit: 255
    t.string   "purpose",           limit: 255
    t.integer  "criticality",       limit: 4
    t.integer  "priority",          limit: 4
    t.integer  "network_id",        limit: 4
    t.integer  "devops_id",         limit: 4
  end

  create_table "datums", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
    t.string   "key",        limit: 255
    t.string   "value",      limit: 255
    t.integer  "valint",     limit: 4
    t.float    "valfloat",   limit: 24
    t.boolean  "truthval"
  end

  create_table "developers", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.integer  "user_id",         limit: 4
    t.integer  "project_id",      limit: 4
    t.string   "skill_level",     limit: 255
    t.string   "languages",       limit: 255
    t.text     "skills",          limit: 65535
    t.string   "job_title",       limit: 255
    t.string   "job_description", limit: 255
  end

  create_table "devops", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.integer  "user_id",         limit: 4
    t.integer  "server_id",       limit: 4
    t.integer  "service_id",      limit: 4
    t.integer  "machine_id",      limit: 4
    t.integer  "database_id",     limit: 4
    t.string   "job_title",       limit: 255
    t.string   "job_description", limit: 255
  end

  create_table "directories", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
    t.integer  "size",            limit: 4
    t.string   "path",            limit: 255
    t.string   "basepath",        limit: 255
    t.string   "grid_membership", limit: 255
    t.boolean  "is_virtual?"
    t.integer  "vfilesystem_id",  limit: 4
    t.integer  "permissions",     limit: 4
    t.integer  "user_id",         limit: 4
    t.integer  "machine_id",      limit: 4
    t.integer  "server_id",       limit: 4
    t.integer  "application_id",  limit: 4
    t.string   "purpose",         limit: 255
    t.string   "description",     limit: 255
    t.datetime "creation"
    t.datetime "modification"
    t.datetime "accessed"
    t.integer  "group_id",        limit: 4
    t.integer  "members",         limit: 4
    t.integer  "harddrive_id",    limit: 4
    t.string   "houses",          limit: 255
    t.string   "role",            limit: 255
  end

  create_table "domainnamesystem", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "ip_id",          limit: 4
    t.string   "cname",          limit: 255
    t.string   "aname",          limit: 255
    t.string   "mx",             limit: 255
    t.string   "mx2",            limit: 255
    t.string   "mx3",            limit: 255
    t.string   "mx4",            limit: 255
    t.string   "hostname",       limit: 255
    t.string   "reverse_lookup", limit: 255
    t.string   "location",       limit: 255
    t.string   "isp",            limit: 255
  end

  create_table "encrypted_file", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name",                 limit: 255
    t.string   "extension",            limit: 255
    t.integer  "size",                 limit: 4
    t.string   "path",                 limit: 255
    t.string   "basepath",             limit: 255
    t.integer  "permissions",          limit: 4
    t.integer  "user_id",              limit: 4
    t.string   "grid_membership",      limit: 255
    t.integer  "machine_id",           limit: 4
    t.integer  "server_id",            limit: 4
    t.integer  "application_id",       limit: 4
    t.integer  "process_id",           limit: 4
    t.boolean  "encrypted?"
    t.string   "encryption_algorithm", limit: 255
    t.integer  "pubkey_id",            limit: 4
    t.integer  "privkey_id",           limit: 4
    t.string   "filetype",             limit: 255
    t.string   "purpose",              limit: 255
    t.string   "description",          limit: 255
    t.datetime "creation"
    t.datetime "modification"
    t.datetime "accessed"
    t.integer  "group_id",             limit: 4
    t.integer  "directory_id",         limit: 4
    t.integer  "vfilesystem_id",       limit: 4
    t.string   "criticality",          limit: 255
  end

  create_table "encryptedfile", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "user_id",        limit: 4
    t.integer  "server_id",      limit: 4
    t.string   "path",           limit: 255
    t.integer  "vfilesystem_id", limit: 4
    t.integer  "privkey",        limit: 4
    t.integer  "pubkey",         limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "files", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name",                 limit: 255
    t.string   "extension",            limit: 255
    t.integer  "size",                 limit: 4
    t.string   "path",                 limit: 255
    t.string   "basepath",             limit: 255
    t.integer  "permissions",          limit: 4
    t.integer  "user_id",              limit: 4
    t.string   "grid_membership",      limit: 255
    t.integer  "machine_id",           limit: 4
    t.integer  "server_id",            limit: 4
    t.integer  "application_id",       limit: 4
    t.integer  "process_id",           limit: 4
    t.boolean  "encrypted?"
    t.string   "encryption_algorithm", limit: 255
    t.integer  "pubkey_id",            limit: 4
    t.integer  "privkey_id",           limit: 4
    t.string   "filetype",             limit: 255
    t.string   "purpose",              limit: 255
    t.string   "description",          limit: 255
    t.datetime "creation"
    t.datetime "modification"
    t.datetime "accessed"
    t.integer  "group_id",             limit: 4
    t.integer  "directory_id",         limit: 4
    t.integer  "vfilesystem_id",       limit: 4
    t.string   "criticality",          limit: 255
  end

  create_table "financials", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.float    "revenue",         limit: 24
    t.float    "profit",          limit: 24
    t.float    "margin",          limit: 24
    t.float    "pe",              limit: 24
    t.float    "eps",             limit: 24
    t.float    "float",           limit: 24
    t.float    "marketcap",       limit: 24
    t.float    "growthrate",      limit: 24
    t.integer  "organization_id", limit: 4
  end

  create_table "girlogs", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.string   "desc",          limit: 255
    t.string   "context",       limit: 255
    t.string   "component",     limit: 255
    t.string   "originator",    limit: 255
    t.text     "body",          limit: 65535
    t.datetime "generated_at"
    t.string   "application",   limit: 255
    t.integer  "facility",      limit: 4
    t.integer  "priority",      limit: 4
    t.string   "criticality",   limit: 255
    t.string   "error",         limit: 255
    t.integer  "error_count",   limit: 4
    t.float    "response_time", limit: 24
    t.float    "latency",       limit: 24
    t.float    "db_latency",    limit: 24
    t.float    "query_time",    limit: 24
    t.string   "query",         limit: 255
    t.integer  "rows_count",    limit: 4
    t.string   "response_code", limit: 255
    t.integer  "http_code",     limit: 4
    t.string   "client",        limit: 255
    t.string   "user",          limit: 255
    t.string   "hostname",      limit: 255
    t.integer  "pid",           limit: 4
    t.string   "program",       limit: 255
  end

  create_table "gists", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "owner",       limit: 255
    t.integer  "user_id",     limit: 4
    t.string "url"
    t.integer  "member_id",   limit: 4
    t.string   "name",        limit: 255
    t.integer  "total_files", limit: 4
    t.string   "description", limit: 255
    t.integer  "total_size",  limit: 4
    t.integer  "github_id",   limit: 4
    t.integer  "git_id",      limit: 4
    t.integer  "project_id",  limit: 4
    t.text     "content",     limit: 65535
  end

  create_table "githubs", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "owner",         limit: 255
    t.integer  "member_id",     limit: 4
    t.string   "username",      limit: 255
    t.string   "password",      limit: 255
    t.string   "apikey",        limit: 255
    t.integer  "user_id",       limit: 4
    t.string   "url",           limit: 255
    t.integer  "membership_id", limit: 4
  end

  create_table "gits", force: :cascade do |t|
  end

  create_table "groups", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",           limit: 255
    t.integer  "vfilesystem_id", limit: 4
    t.integer  "user",           limit: 4
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.string   "purpose",        limit: 255
    t.datetime "incept_date"
    t.integer  "access_level",   limit: 4
  end

  create_table "harddrives", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "description",       limit: 255
    t.string   "mount_point",       limit: 255
    t.string   "device",            limit: 255
    t.string   "UUID",              limit: 255
    t.float    "available",         limit: 24
    t.float    "size",              limit: 24
    t.float    "used",              limit: 24
    t.float    "percent_used",      limit: 24
    t.string   "filesystem",        limit: 255
    t.integer  "vfilesystem_id",    limit: 4
    t.integer  "machine_id",        limit: 4
    t.integer  "criticality",       limit: 4
    t.integer  "server_id",         limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "raid",              limit: 255
    t.string   "drive_type",        limit: 255
    t.string   "drive_interface",   limit: 255
    t.boolean  "external?"
  end

  create_table "hardwares", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.integer  "user_id",       limit: 4
    t.integer  "machine_id",    limit: 4
    t.integer  "inventory_id",  limit: 4
    t.integer  "operations_id", limit: 4
    t.string   "type",          limit: 255
    t.string   "purpose",       limit: 255
    t.string   "identifier",    limit: 255
    t.string   "size",          limit: 255
    t.string   "description",   limit: 255
    t.text     "details",       limit: 65535
  end

  create_table "images", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.string   "path",        limit: 255
    t.string   "type",        limit: 255
    t.string   "description", limit: 255
    t.integer  "size",        limit: 4
    t.binary   "silo",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "infrastructures", force: :cascade do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name",                         limit: 255
    t.string   "purpose",                      limit: 255
    t.string   "description",                  limit: 255
    t.string   "type",                         limit: 255
    t.float    "effectiveness",                limit: 24
    t.float    "utilization",                  limit: 24
    t.float    "return_on_assets",             limit: 24
    t.float    "manhours_per_unit_production", limit: 24
    t.float    "revenue_per_employee",         limit: 24
    t.string   "organizational_unit",          limit: 255
    t.float    "total_klocs",                  limit: 24
    t.float    "klocs_ytd",                    limit: 24
    t.float    "total_manhours",               limit: 24
    t.float    "manhours_this_month",          limit: 24
    t.float    "manhours_last_month",          limit: 24
    t.float    "average_manhours",             limit: 24
    t.float    "bugs_this_month",              limit: 24
    t.float    "bugs_last_month",              limit: 24
    t.float    "average_bugs_month",           limit: 24
    t.float    "klocs_this_month",             limit: 24
    t.float    "klocs_last_month",             limit: 24
    t.float    "average_klocs_month",          limit: 24
    t.float    "klocs_per_manhour",            limit: 24
    t.float    "bugs_per_kloc",                limit: 24
    t.float    "defect_removal_rate",          limit: 24
    t.string   "service",                      limit: 255
    t.string   "application",                  limit: 255
    t.integer  "cluster_id",                   limit: 4
    t.integer  "user_id",                      limit: 4
    t.integer  "criticality",                  limit: 4
    t.string   "network",                      limit: 255
    t.integer  "admin_id",                     limit: 4
    t.integer  "operations_id",                limit: 4
  end

  create_table "instance_configs", force: :cascade do |t|
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.integer  "ban_duration",      limit: 4,     default: 3888000
    t.integer  "invalid_weight",    limit: 4,     default: 45
    t.integer  "failed_weight",     limit: 4,     default: 10
    t.integer  "sensitivity",       limit: 4,     default: 100
    t.string   "log_location",      limit: 255,   default: "/var/log/auth.log"
    t.string   "denyfile_location", limit: 255,   default: "/etc/hosts.deny"
    t.string   "error_log",         limit: 255,   default: "/var/log/emergence/error.log"
    t.integer  "delay",             limit: 4,     default: 60
    t.integer  "retry",             limit: 4,     default: 60
    t.string   "instance_id",       limit: 255
    t.text     "pcap_location",     limit: 65535
    t.text     "pcap_filter",       limit: 65535
    t.text     "pcap_interface",    limit: 65535
    t.integer  "update_flag",       limit: 4,     default: 0
    t.boolean  "stats_log?"
    t.boolean  "stats_pcap?"
    t.boolean  "monitor_log?"
    t.boolean  "monitor_pcap?"
    t.text     "instance_info",     limit: 65535
    t.integer  "extrainteger",      limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",       limit: 255
    t.text     "extratext",         limit: 65535
  end

  create_table "instances", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "instance_type",  limit: 255
    t.string   "gucid",          limit: 255
    t.string   "hostname",       limit: 255
    t.string   "facility",       limit: 255
    t.string   "extended_stats", limit: 255
    t.string   "ip",             limit: 255
    t.boolean  "subscribed",                   default: false, null: false
    t.boolean  "installed",                    default: false, null: false
    t.datetime "alive"
    t.string   "description",    limit: 255
    t.string   "human_name",     limit: 255
    t.integer  "server_id",      limit: 4
    t.integer  "machine_id",     limit: 4
    t.boolean  "aggregation",                  default: false
    t.integer  "extrainteger",   limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",    limit: 255
    t.text     "extratext",      limit: 65535
    t.float    "extrafloat",     limit: 24
  end

  create_table "ips", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "address",         limit: 255
    t.integer  "hostname",        limit: 4
    t.string   "dns",             limit: 255
    t.string   "isp",             limit: 255
    t.string   "netblock",        limit: 255
    t.string   "subnet",          limit: 255
    t.integer  "network_id",      limit: 4
    t.integer  "reputation",      limit: 4
    t.integer  "dns_id",          limit: 4
    t.integer  "organization_id", limit: 4
  end

  create_table "issuelists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.integer  "project_id",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "issues", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "author",     limit: 255
    t.string   "assignee",   limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "labels",     limit: 255
    t.integer  "issuelist_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "quantity",     limit: 4
    t.string   "name",         limit: 255
    t.string   "desc",         limit: 255
    t.string   "value",        limit: 255
    t.float    "quan",         limit: 24
    t.float    "amount",       limit: 24
    t.integer  "priority",     limit: 4
    t.integer  "inventory_id", limit: 4
    t.integer  "project_id",   limit: 4
  end

  create_table "labels", force: :cascade do |t|
    t.string  "name",         limit: 255
    t.integer "color"
    t.string "colorstr"
    t.string  "label",        limit: 255
    t.integer "issue_id",     limit: 4
    t.integer "task_id"
    t.integer "todo_id"
    t.integer "project_id"
    t.integer "milestone_id", limit: 4
  end

  create_table "logentries", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "logfile_id",  limit: 4
    t.string   "name",        limit: 255
    t.text     "message",     limit: 65535
    t.string   "facility",    limit: 255
    t.integer  "priority",    limit: 4
    t.datetime "logged_at"
    t.string   "service",     limit: 255
    t.integer  "service_id",  limit: 4
    t.integer  "logentry_id", limit: 4
  end

  create_table "logfiles", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "machine_id",      limit: 4
    t.string   "name",            limit: 255
    t.string   "description",     limit: 255
    t.float    "size",            limit: 24
    t.integer  "entries",         limit: 4
    t.float    "entries_per_sec", limit: 24
    t.string   "location",        limit: 255
    t.string   "path",            limit: 255
    t.string   "basename",        limit: 255
    t.string   "service",         limit: 255
    t.integer  "service_id",      limit: 4
    t.integer  "server_id",       limit: 4
    t.integer  "criticality",     limit: 4
  end

  create_table "machinelearners", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "desc",              limit: 255
    t.integer  "cluster_id",        limit: 4
    t.integer  "server_id",         limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.integer  "manager_id",        limit: 4
  end

  create_table "machines", force: :cascade do |t|
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "name",                         limit: 255
    t.string   "executor",                     limit: 255
    t.string   "remote_execution",             limit: 255
    t.boolean  "remote_execution_capability?"
    t.integer  "user_id",                      limit: 4
    t.integer  "cluster_id",                   limit: 4
    t.integer  "system_id",                    limit: 4
    t.integer  "ip_id",                        limit: 4
    t.integer  "organization_id",              limit: 4
    t.string   "cid",                          limit: 255,   default: "none"
    t.string   "ip",                           limit: 255
    t.string   "hostname",                     limit: 255
    t.string   "physical_host",                limit: 255
    t.string   "is_virtual?",                  limit: 255,   default: "1"
    t.integer  "ram",                          limit: 4
    t.integer  "virtual_servers_hosted",       limit: 4
    t.integer  "cpus",                         limit: 4
    t.text     "configuration",                limit: 65535
    t.integer  "ghz",                          limit: 4
    t.string   "cputype",                      limit: 255
    t.integer  "ipaddr",                       limit: 4
    t.string   "available_disk_slots",         limit: 255
    t.string   "total_disk_slots",             limit: 255
    t.string   "pci_express_expansion0",       limit: 255
    t.string   "pci_express_expansion1",       limit: 255
    t.integer  "pci_express_slots",            limit: 4
    t.integer  "pci_express_available",        limit: 4
    t.string   "ram_type",                     limit: 255
    t.string   "ram_speed",                    limit: 255
    t.integer  "total_ram_slots",              limit: 4
    t.integer  "available_ram_slots",          limit: 4
    t.integer  "ram_available",                limit: 4
    t.integer  "ram_cached",                   limit: 4
    t.integer  "ram_buffers",                  limit: 4
    t.integer  "ram_swap",                     limit: 4
    t.float    "load1m",                       limit: 24
    t.float    "load5m",                       limit: 24
    t.float    "load15m",                      limit: 24
    t.string   "type_of_storage",              limit: 255
    t.string   "external_storage",             limit: 255
    t.string   "raid",                         limit: 255
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
    t.integer  "uptime",                       limit: 4
    t.integer  "extrainteger",                 limit: 4
    t.boolean  "extraboolean?"
    t.string   "extrastring",                  limit: 255
    t.text     "extratext",                    limit: 65535
    t.float    "extrafloat",                   limit: 24
    t.string   "silicond",                     limit: 255
    t.string   "highwayd",                     limit: 255
    t.string   "emdaemon",                     limit: 255
    t.string   "processing_uri",               limit: 255
    t.boolean  "master?"
    t.integer  "network_id",                   limit: 4
    t.integer  "manager_id",                   limit: 4
    t.string   "os",                           limit: 255
    t.integer  "devops_id",                    limit: 4
  end

  create_table "managers", force: :cascade do |t|
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name",                     limit: 255
    t.string   "purpose",                  limit: 255
    t.string   "resources",                limit: 255
    t.string   "hostname",                 limit: 255
    t.integer  "infrastructure_id",        limit: 4
    t.integer  "cluster_id",               limit: 4
    t.string   "management_software",      limit: 255
    t.integer  "admin_id",                 limit: 4
    t.string   "message_passing_software", limit: 255
    t.text     "detail",                   limit: 65535
  end

  create_table "members", force: :cascade do |t|
    t.string   "email",              limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", limit: 255
    t.string   "hashed_password",    limit: 255
    t.string   "key",                limit: 255
    t.string   "salt",               limit: 255
    t.string   "name",               limit: 255
    t.string   "fullname",           limit: 255
    t.string   "username",           limit: 255
    t.string   "address1",           limit: 255
    t.string   "address2",           limit: 255
    t.string   "city",               limit: 255
    t.string   "state",              limit: 255
    t.string   "zip",                limit: 255
    t.string   "phone",              limit: 255
    t.string   "lastlog_ip",         limit: 255
    t.datetime "lastlog"
    t.boolean  "logged_in?"
    t.string   "country",            limit: 255
    t.string   "company",            limit: 255
    t.string   "job_title",          limit: 255
  end

  create_table "memberships", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.integer  "user_id",    limit: 4
    t.integer  "member_id",  limit: 4
    t.string   "password",   limit: 255
    t.string   "username",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "application_id", limit: 4
    t.integer  "service_id",     limit: 4
    t.integer  "process_id",     limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "username_id",    limit: 4
    t.string   "summary",        limit: 255
    t.string   "message",        limit: 255
    t.string   "response",       limit: 255
    t.text     "body",           limit: 65535
    t.string   "header",         limit: 255
    t.string   "type",           limit: 255
    t.string   "concerning",     limit: 255
    t.boolean  "top_secret?"
    t.integer  "priority",       limit: 4
    t.string   "destination",    limit: 255
    t.string   "source",         limit: 255
  end

  create_table "milestones", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "name",       limit: 255
    t.string   "heading",    limit: 255
    t.text     "body",       limit: 65535
    t.integer "issue_id"
    t.integer "task_id"
    t.integer "todo_id"
    t.integer "project_id"
    t.datetime "duedate"
    t.float    "complete",   limit: 24
    t.integer  "open",       limit: 4
    t.integer  "closed",     limit: 4
  end

  create_table "nameservers", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name",              limit: 255
    t.string   "nameserver",        limit: 255
    t.string   "nameserver2",       limit: 255
    t.string   "nameserver3",       limit: 255
    t.boolean  "primary?"
    t.string   "netblock",          limit: 255
    t.string   "inet_authority",    limit: 255
    t.float    "ping",              limit: 24
    t.integer  "hops",              limit: 4
    t.float    "latency",           limit: 24
    t.string   "googlens",          limit: 255
    t.string   "googlens2",         limit: 255
    t.integer  "network_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.integer  "machine_id",        limit: 4
    t.integer  "server_id",         limit: 4
    t.string   "description",       limit: 255
    t.text     "configuration",     limit: 65535
    t.integer  "organization_id",   limit: 4
  end

  create_table "namevariables", force: :cascade do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "title",                        limit: 255
    t.string   "infrastructure_name",          limit: 255
    t.string   "cluster_name",                 limit: 255
    t.string   "left_menu_header",             limit: 255
    t.string   "left_menu_header_nav",         limit: 255
    t.string   "central_logging_server",       limit: 255
    t.string   "app_name",                     limit: 255
    t.string   "company_name",                 limit: 255
    t.string   "nav1",                         limit: 255
    t.string   "nav2",                         limit: 255
    t.string   "nav3",                         limit: 255
    t.string   "nav4",                         limit: 255
    t.string   "nav5",                         limit: 255
    t.string   "nav6",                         limit: 255
    t.string   "nav7",                         limit: 255
    t.string   "nav8",                         limit: 255
    t.string   "nav9",                         limit: 255
    t.string   "nav10",                        limit: 255
    t.string   "first_topbar_icon",            limit: 255
    t.string   "first_topbar_icon_bot",        limit: 255
    t.string   "second_topbar_icon",           limit: 255
    t.string   "second_topbar_icon_bot",       limit: 255
    t.string   "third_topbar_icon",            limit: 255
    t.string   "third_topbar_icon_bot",        limit: 255
    t.string   "mini_topbar_banner_name",      limit: 255
    t.string   "mini_topbar_banner_first",     limit: 255
    t.string   "mini_topbar_banner_second",    limit: 255
    t.string   "mini_topbar_banner_third",     limit: 255
    t.string   "mini_topbar_banner_right",     limit: 255
    t.string   "mini_topbar_banner_left",      limit: 255
    t.string   "right_bar_heading_one",        limit: 255
    t.string   "right_bar_first_heading_one_", limit: 255
    t.string   "right_bar_first_heading_two",  limit: 255
    t.string   "right_bar_heading_two",        limit: 255
    t.string   "right_bar_sec_heading_one_",   limit: 255
    t.string   "right_bar_sec_heading_two",    limit: 255
    t.string   "footer_company",               limit: 255
    t.string   "footer_years",                 limit: 255
    t.string   "footer_trailer_one",           limit: 255
    t.string   "footer_link1",                 limit: 255
    t.string   "footer_link2",                 limit: 255
    t.string   "footer_link3",                 limit: 255
    t.string   "footer_link4",                 limit: 255
    t.string   "footer_link5",                 limit: 255
    t.string   "footer_link6",                 limit: 255
    t.string   "footer_link7",                 limit: 255
    t.string   "sysop",                        limit: 255
    t.string   "admin",                        limit: 255
    t.string   "operations_manager",           limit: 255
    t.string   "emergency_contact",            limit: 255
    t.string   "security_contact",             limit: 255
    t.string   "customer_contact",             limit: 255
    t.string   "sales_contact",                limit: 255
    t.string   "support_contact",              limit: 255
    t.string   "hr_contact",                   limit: 255
    t.string   "designer",                     limit: 255
    t.string   "layout_name",                  limit: 255
    t.string   "organization_address",         limit: 255
    t.string   "organization_phone",           limit: 255
    t.string   "organization_email",           limit: 255
  end

  create_table "network_boxes", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name",              limit: 255
    t.string   "hostname",          limit: 255
    t.string   "ip",                limit: 255
    t.string   "type",              limit: 255
    t.string   "manufacturer",      limit: 255
    t.string   "model",             limit: 255
    t.string   "router",            limit: 255
    t.string   "gateway",           limit: 255
    t.integer  "network_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "gateway_ip",        limit: 255
    t.string   "os",                limit: 255
    t.integer  "operations_id",     limit: 4
    t.text     "configuration",     limit: 65535
  end

  create_table "networks", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "purpose",           limit: 255
    t.string   "type",              limit: 255
    t.integer  "speed",             limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "ownership",         limit: 255
    t.string   "netadmin",          limit: 255
    t.integer  "user_id",           limit: 4
    t.integer  "cluster_id",        limit: 4
    t.string   "gateway_ip",        limit: 255
    t.float    "ping",              limit: 24
    t.integer  "hops",              limit: 4
    t.float    "latency",           limit: 24
    t.string   "router_ip",         limit: 255
    t.string   "broadcast",         limit: 255
    t.string   "address_space",     limit: 255
    t.string   "dns",               limit: 255
    t.string   "ptr_record",        limit: 255
    t.string   "a_record",          limit: 255
    t.string   "reverse_address",   limit: 255
    t.integer  "network_box",       limit: 4
    t.integer  "operations_id",     limit: 4
    t.string   "wifi_ssid",         limit: 255
    t.string   "wan_ip",            limit: 255
    t.string   "lan_ip",            limit: 255
  end

  create_table "neuralnetworks", force: :cascade do |t|
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "name",               limit: 255
    t.string   "desc",               limit: 255
    t.string   "type",               limit: 255
    t.boolean  "back_propagating?"
    t.integer  "hidden_neurons",     limit: 4
    t.integer  "neurons",            limit: 4
    t.integer  "inputs",             limit: 4
    t.integer  "outputs",            limit: 4
    t.string   "training_data_path", limit: 255
    t.text     "neuralnet",          limit: 65535
    t.integer  "machinelearner_id",  limit: 4
  end

  create_table "nodes", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
    t.integer  "server_id",  limit: 4
    t.string   "hostname",   limit: 255
    t.string   "ip",         limit: 255
    t.integer  "ipaddr",     limit: 4
    t.integer  "machine_id", limit: 4
    t.string   "value",      limit: 255
    t.float    "quantity",   limit: 24
    t.integer  "number",     limit: 4
    t.integer  "manager_id", limit: 4
    t.string   "os",         limit: 255
    t.integer  "devops_id",  limit: 4
  end

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "machine_id",     limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "server_id",      limit: 4
    t.string   "message",        limit: 255
    t.integer  "priority",       limit: 4
    t.string   "source",         limit: 255
    t.string   "destination",    limit: 255
    t.integer  "cluster_id",     limit: 4
    t.integer  "service_id",     limit: 4
    t.integer  "application_id", limit: 4
  end

  create_table "openports", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 255
    t.string   "desc",       limit: 255
    t.integer  "port",       limit: 4
    t.integer  "ip_id",      limit: 4
    t.integer  "service_id", limit: 4
    t.integer  "network_id", limit: 4
  end

  create_table "operations", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "description",       limit: 255
    t.integer  "user_id",           limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "job_title",         limit: 255
    t.string   "job_description",   limit: 255
  end

  create_table "organizations", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "address",     limit: 255
    t.string   "phone",       limit: 255
    t.integer  "employees",   limit: 4
    t.text     "details",     limit: 65535
    t.string   "description", limit: 255
    t.integer  "criticality", limit: 4
  end

  create_table "pagelocations", force: :cascade do |t|
    t.integer "position",   limit: 4
    t.integer "word_id",    limit: 4
    t.integer "webpage_id", limit: 4
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "header",      limit: 255
    t.text     "body",        limit: 65535
    t.text     "content",     limit: 65535
    t.string   "title",       limit: 255
    t.string   "subtitle",    limit: 255
    t.string   "subheading",  limit: 255
    t.boolean  "static?"
    t.string   "page",        limit: 255
    t.integer  "page_number", limit: 4
    t.string   "description", limit: 255
    t.string   "app_name",    limit: 255
  end

  create_table "pgpkeys", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "keyname",     limit: 255
    t.string   "email",       limit: 255
    t.string   "type",        limit: 255
    t.string   "keyid",       limit: 255
    t.string   "comment",     limit: 255
    t.string   "use",         limit: 255
    t.binary   "photo",       limit: 65535
    t.integer  "picture_id",  limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "member_id",   limit: 4
    t.integer  "username_id", limit: 4
    t.text     "key",         limit: 65535
    t.text "private_key"
    t.binary   "keyblob",     limit: 65535
    t.string   "alt_name",    limit: 255
    t.string   "alt_email",   limit: 255
    t.string   "alt_comment", limit: 255
    t.string   "primary",     limit: 255
    t.string   "sign",        limit: 255
    t.boolean  "encrypting?"
    t.boolean  "signing?"
    t.boolean  "primary?"
  end


  create_table "secrets", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "source",       limit: 255
    t.string   "description",  limit: 255
    t.integer  "user_id",      limit: 4
    t.text "secret"
    t.text "key"
    t.text "privkey"

  end


  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "upload_id",    limit: 4
    t.integer  "file_id",      limit: 4
    t.integer  "directory_id", limit: 4
    t.string   "name",         limit: 255
    t.string   "location",     limit: 255
    t.integer  "vfilesystem",  limit: 4
    t.string   "source",       limit: 255
    t.string   "description",  limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "server_id",    limit: 4
  end

  create_table "pinups", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "upload_id",    limit: 4
    t.integer  "file_id",      limit: 4
    t.integer  "directory_id", limit: 4
    t.string   "name",         limit: 255
    t.string   "location",     limit: 255
    t.integer  "vfilesystem",  limit: 4
    t.string   "source",       limit: 255
    t.string   "description",  limit: 255
    t.integer  "user_id",      limit: 4
    t.integer  "server_id",    limit: 4
  end

  create_table "plates", force: :cascade do |t|
    t.string  "value",     limit: 255
    t.integer "ival",      limit: 4
    t.float   "fval",      limit: 24
    t.integer "queque_id", limit: 4
  end

  create_table "privkeys", force: :cascade do |t|
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "name",           limit: 255
    t.string   "location",       limit: 255
    t.string   "userhost",       limit: 255
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "user_id",        limit: 4
    t.integer  "username_id",    limit: 4
    t.integer  "member_id",      limit: 4
    t.integer  "pgpkey_id",      limit: 4
    t.text     "key",            limit: 65535
    t.string   "type",           limit: 255
    t.integer  "bits",           limit: 4
    t.string   "purpose",        limit: 255
    t.integer  "keynumber",      limit: 4
    t.boolean  "encryptor?"
    t.string   "generator",      limit: 255
    t.datetime "expiration"
    t.string   "keyserver",      limit: 255
    t.boolean  "high_security?"
  end

  create_table "processes", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",           limit: 255
    t.integer  "pid",            limit: 4
    t.string   "process",        limit: 255
    t.string   "filehandles",    limit: 255
    t.integer  "filehandle",     limit: 4
    t.string   "path",           limit: 255
    t.float    "proctime",       limit: 24
    t.float    "walltime",       limit: 24
    t.float    "io",             limit: 24
    t.float    "netio",          limit: 24
    t.float    "iowait",         limit: 24
    t.float    "memory",         limit: 24
    t.integer  "machine_id",     limit: 4
    t.integer  "server_id",      limit: 4
    t.integer  "node_id",        limit: 4
    t.integer  "network_id",     limit: 4
    t.integer  "manager_id",     limit: 4
    t.integer  "application_id", limit: 4
    t.integer  "service_id",     limit: 4
  end

  create_table "product_engineering", force: :cascade do |t|
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "name",                         limit: 255
    t.string   "purpose",                      limit: 255
    t.string   "description",                  limit: 255
    t.string   "type",                         limit: 255
    t.string   "business_unit",                limit: 255
    t.float    "effectiveness",                limit: 24
    t.float    "utilization",                  limit: 24
    t.float    "return_on_assets",             limit: 24
    t.float    "manhours_per_unit_production", limit: 24
    t.float    "revenue_per_employee",         limit: 24
    t.string   "organizational_unit",          limit: 255
    t.float    "total_klocs",                  limit: 24
    t.float    "klocs_ytd",                    limit: 24
    t.float    "total_manhours",               limit: 24
    t.float    "manhours_this_month",          limit: 24
    t.float    "manhours_last_month",          limit: 24
    t.float    "manhours_prev_prev__month",    limit: 24
    t.float    "rolling_avg_manhours_month",   limit: 24
    t.float    "bugs_this_month",              limit: 24
    t.float    "bugs_last_month",              limit: 24
    t.float    "average_bugs_month",           limit: 24
    t.float    "klocs_this_month",             limit: 24
    t.float    "klocs_last_month",             limit: 24
    t.float    "average_klocs_month",          limit: 24
    t.float    "klocs_per_manhour",            limit: 24
    t.float    "bugs_per_kloc",                limit: 24
    t.float    "defect_removal_rate",          limit: 24
    t.string   "service",                      limit: 255
    t.string   "application",                  limit: 255
    t.integer  "cluster_id",                   limit: 4
    t.integer  "user_id",                      limit: 4
    t.integer  "criticality",                  limit: 4
    t.string   "network",                      limit: 255
    t.integer  "operations_id",                limit: 4
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name",                  limit: 255
    t.string   "description",           limit: 255
    t.text     "details",               limit: 65535
    t.integer  "infrastructure_id",     limit: 4
    t.integer  "research_id",           limit: 4
    t.integer  "developer_id",          limit: 4
    t.integer  "application_id",        limit: 4
    t.datetime "projected_completion"
    t.integer  "username_id",           limit: 4
    t.integer  "user_id",               limit: 4
    t.integer  "member_id",             limit: 4
    t.integer  "manhours",              limit: 4
    t.integer  "eta",                   limit: 4
    t.float    "completion_percentage", limit: 24
  end

  create_table "pubkeys", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "userhost",    limit: 255
    t.string   "location",    limit: 255
    t.integer  "machine_id",  limit: 4
    t.integer  "server_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "pgpkey_id",   limit: 4
    t.text     "key",         limit: 65535
    t.string   "type",        limit: 255
    t.integer  "bits",        limit: 4
    t.string   "purpose",     limit: 255
    t.integer  "keynumber",   limit: 4
    t.boolean  "encryptor?"
    t.string   "generator",   limit: 255
    t.datetime "expiration"
    t.string   "keyserver",   limit: 255
    t.integer  "username_id", limit: 4
    t.integer  "member_id",   limit: 4
  end

  create_table "pubservers", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "ip",                limit: 255
    t.string   "hostname",          limit: 255
    t.string   "os",                limit: 255
    t.string   "dns",               limit: 255
    t.string   "whois",             limit: 255
    t.string   "organization",      limit: 255
    t.integer  "organization_id",   limit: 4
    t.integer  "reputation_id",     limit: 4
    t.string   "url",               limit: 255
    t.string   "applications",      limit: 255
    t.integer  "application_id",    limit: 4
    t.integer  "service_id",        limit: 4
    t.string   "app_version",       limit: 255
    t.string   "webserver",         limit: 255
    t.string   "webserver_id",      limit: 255
    t.string   "webserver_version", limit: 255
  end

  create_table "pubservices", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",         limit: 255
    t.string   "service",      limit: 255
    t.string   "description",  limit: 255
    t.string   "hostname",     limit: 255
    t.integer  "criticality",  limit: 4
    t.integer  "priority",     limit: 4
    t.string   "organization", limit: 255
    t.string   "isp",          limit: 255
    t.string   "status",       limit: 255
    t.string   "ip",           limit: 255
    t.string   "dns",          limit: 255
    t.string   "owner",        limit: 255
    t.text     "whois",        limit: 65535
    t.text     "details",      limit: 65535
    t.boolean  "secure?"
    t.string   "url",          limit: 255
    t.boolean  "up?"
    t.string   "provides",     limit: 255
    t.string   "uri",          limit: 255
    t.string   "api",          limit: 255
    t.integer  "pubserver_id", limit: 4
  end

  create_table "queques", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",        limit: 255
    t.integer  "critlarm_id", limit: 4
  end

  create_table "rejexes", force: :cascade do |t|
    t.string "name",          limit: 255
    t.string "description",   limit: 255
    t.string "body",          limit: 255
    t.string "flag",          limit: 255
    t.string "flag2",         limit: 255
    t.string "flag3",         limit: 255
    t.string "flag4",         limit: 255
    t.string "flag5",         limit: 255
    t.string "flag6",         limit: 255
    t.string "pattern",       limit: 255
    t.string "pattern2",      limit: 255
    t.string "substitute",    limit: 255
    t.string "return_field",  limit: 255
    t.string "return_field1", limit: 255
    t.string "return_field2", limit: 255
    t.string "return_field3", limit: 255
    t.string "return_field4", limit: 255
    t.string "serialized",    limit: 255
  end

  create_table "repositories", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "owner",         limit: 255
    t.integer  "user_id",       limit: 4
    t.integer  "member_id",     limit: 4
    t.string   "name",          limit: 255
    t.integer  "total_files",   limit: 4
    t.integer  "total_size",    limit: 4
    t.integer  "subversion_id", limit: 4
    t.integer  "github_id",     limit: 4
    t.integer  "git_id",        limit: 4
    t.integer  "project_id",    limit: 4
  end

  create_table "reputations", force: :cascade do |t|
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "ip_id",      limit: 4
    t.integer  "value",      limit: 4
  end

  create_table "researchers", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name",              limit: 255
    t.string   "description",       limit: 255
    t.text     "details",           limit: 65535
    t.integer  "user_id",           limit: 4
    t.integer  "project_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "job_title",         limit: 255
    t.string   "job_description",   limit: 255
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

  create_table "routers", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "hostname",          limit: 255
    t.string   "ip",                limit: 255
    t.string   "type",              limit: 255
    t.string   "manufacturer",      limit: 255
    t.string   "model",             limit: 255
    t.string   "routing",           limit: 255
    t.float    "ping",              limit: 24
    t.integer  "hops",              limit: 4
    t.float    "latency",           limit: 24
    t.string   "routes",            limit: 255
    t.string   "gateway",           limit: 255
    t.integer  "network_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "gateway_ip",        limit: 255
    t.string   "os",                limit: 255
    t.integer  "operations_id",     limit: 4
  end

  create_table "routes", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",              limit: 255
    t.string   "hostname",          limit: 255
    t.string   "ip",                limit: 255
    t.string   "type",              limit: 255
    t.float    "ping",              limit: 24
    t.integer  "hops",              limit: 4
    t.float    "latency",           limit: 24
    t.string   "router_id",         limit: 255
    t.integer  "network_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.string   "gateway_ip",        limit: 255
    t.string   "destination",       limit: 255
    t.string   "source",            limit: 255
    t.string   "protocol",          limit: 255
    t.float    "traffic",           limit: 24
    t.integer  "traffic_load",      limit: 4
    t.integer  "operations_id",     limit: 4
  end

  create_table "searches", force: :cascade do |t|
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "field",      limit: 255
    t.string   "field2",     limit: 255
    t.string   "field3",     limit: 255
    t.string   "field4",     limit: 255
    t.string   "field5",     limit: 255
    t.string   "field6",     limit: 255
    t.string   "field7",     limit: 255
  end

  create_table "servers", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.string   "username",      limit: 255
    t.string   "password",      limit: 255
    t.text     "privkey",       limit: 65535
    t.text     "pubkey",        limit: 65535
    t.text     "key",           limit: 65535
    t.string   "ip",            limit: 255
    t.string   "hostname",      limit: 255
    t.string   "cluster",       limit: 255
    t.integer  "ipaddr",        limit: 4
    t.string   "type",          limit: 255
    t.integer  "machine_id",    limit: 4
    t.integer  "cluster_id",    limit: 4
    t.boolean  "virtual?"
    t.boolean  "up?"
    t.integer  "criticality",   limit: 4
    t.integer  "priority",      limit: 4
    t.integer  "network_id",    limit: 4
    t.integer  "manager_id",    limit: 4
    t.string   "os",            limit: 255
    t.integer  "devops_id",     limit: 4
    t.integer  "uptime",        limit: 4
    t.integer  "system_id",     limit: 4
    t.integer  "user_id",       limit: 4
    t.text     "configuration", limit: 65535
  end

  create_table "services", force: :cascade do |t|
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",          limit: 255
    t.string   "description",   limit: 255
    t.string   "type",          limit: 255
    t.string   "location",      limit: 255
    t.integer  "server_id",     limit: 4
    t.integer  "webserver_id",  limit: 4
    t.integer  "machine_id",    limit: 4
    t.integer  "cluster_id",    limit: 4
    t.integer  "user_id",       limit: 4
    t.string   "distribution",  limit: 255
    t.string   "cluster",       limit: 255
    t.string   "replication",   limit: 255
    t.string   "authority",     limit: 255
    t.string   "purpose",       limit: 255
    t.string   "watchdog",      limit: 255
    t.integer  "pid",           limit: 4
    t.integer  "criticality",   limit: 4
    t.integer  "priority",      limit: 4
    t.integer  "network_id",    limit: 4
    t.integer  "manager_id",    limit: 4
    t.integer  "devops_id",     limit: 4
    t.text     "configuration", limit: 65535
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

  create_table "source_controls", force: :cascade do |t|
  end

  create_table "spyders", force: :cascade do |t|
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.string   "name",                   limit: 255
    t.string   "type",                   limit: 255
    t.text     "details",                limit: 65535
    t.string   "spyder_name",            limit: 255
    t.string   "hostname",               limit: 255
    t.string   "user_agent",             limit: 255
    t.text     "spec",                   limit: 65535
    t.text     "search_terms",           limit: 65535
    t.float    "uptime",                 limit: 24
    t.float    "data_down",              limit: 24
    t.float    "data_up",                limit: 24
    t.integer  "images",                 limit: 4
    t.integer  "videos",                 limit: 4
    t.integer  "documents",              limit: 4
    t.string   "starting_url",           limit: 255
    t.string   "starting_url2",          limit: 255
    t.string   "alternate_starting_url", limit: 255
    t.integer  "ip_id",                  limit: 4
    t.string   "download_location",      limit: 255
    t.boolean  "bfs?"
    t.float    "delay",                  limit: 24,    default: 1.0
    t.integer  "processes",              limit: 4
  end

  create_table "statistics", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "machine_id",         limit: 4
    t.string   "name",               limit: 255
    t.string   "description",        limit: 255
    t.string   "value",              limit: 255
    t.boolean  "active?"
    t.integer  "quantity",           limit: 4
    t.float    "rateofchange",       limit: 24
    t.integer  "rate",               limit: 4
    t.integer  "previous_qty",       limit: 4
    t.float    "historical",         limit: 24
    t.float    "historical_average", limit: 24
    t.string   "transport",          limit: 255
    t.float    "amount",             limit: 24
    t.float    "current_value",      limit: 24
    t.float    "previous_value",     limit: 24
    t.float    "percentage",         limit: 24
    t.integer  "priority",           limit: 4
    t.integer  "service_id",         limit: 4
    t.integer  "user_id",            limit: 4
    t.integer  "server_id",          limit: 4
    t.integer  "application_id",     limit: 4
    t.integer  "process_id",         limit: 4
    t.integer  "network_id",         limit: 4
  end

  create_table "subversions", force: :cascade do |t|
  end

  create_table "systemevents", force: :cascade do |t|
    t.text     "Message",            limit: 65535
    t.integer  "Facility",           limit: 4
    t.string   "FromHost",           limit: 255
    t.datetime "DeviceReportedTime"
    t.datetime "ReceivedAt"
    t.integer  "InfoUnitID",         limit: 4
    t.string   "SysLogTag",          limit: 255
  end

  create_table "systems", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "name",              limit: 255
    t.integer  "cluster_id",        limit: 4
    t.integer  "infrastructure_id", limit: 4
    t.integer  "criticality",       limit: 4
    t.string   "description",       limit: 255
    t.float    "version",           limit: 24
    t.text     "body",              limit: 65535
  end

  create_table "tables", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "rows",           limit: 4
    t.string  "row_headings",   limit: 255
    t.text    "content",        limit: 65535
    t.string  "columns",        limit: 255
    t.integer "columns_count",  limit: 4
    t.integer "application_id", limit: 4
    t.integer "database_id",    limit: 4
    t.string  "purpose",        limit: 255
    t.integer "criticality",    limit: 4
  end

  create_table "tasklists", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "desc",        limit: 255
    t.integer  "total_tasks", limit: 4
    t.integer  "project_id",  limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.text     "body",        limit: 65535
    t.text     "content",     limit: 65535
    t.string   "header",      limit: 255
    t.string   "heading_one", limit: 255
    t.string   "heading_two", limit: 255
    t.integer  "project_id",  limit: 4
  end

  create_table "todos", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "desc",                  limit: 255
    t.datetime "eta"
    t.integer  "estimated_manhours",    limit: 4
    t.integer  "total_manhours",        limit: 4
    t.float    "ratio_actual_manhours", limit: 24
    t.text     "details",               limit: 65535
    t.integer  "tasklist_id",           limit: 4
    t.integer  "user_id",               limit: 4
    t.integer  "priority",              limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "torrents", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "url",            limit: 255
    t.string   "tracker",        limit: 255
    t.string   "torrentfile",    limit: 255
    t.binary   "torrent",        limit: 65535
    t.string   "location",       limit: 255
    t.integer  "server_id",      limit: 4
    t.integer  "application_id", limit: 4
    t.integer  "torrentsite",    limit: 4
  end

  create_table "torrentsites", force: :cascade do |t|
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",          limit: 255
    t.string   "url",           limit: 255
    t.string   "search_string", limit: 255
    t.string   "tracker",       limit: 255
    t.integer  "spyder_id",     limit: 4
  end

  create_table "uploads", force: :cascade do |t|
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "name",                limit: 255
    t.string   "filetype",            limit: 255
    t.string   "description",         limit: 255
    t.binary   "file",                limit: 65535
    t.string   "path",                limit: 255
    t.string   "hosted_on",           limit: 255
    t.integer  "server_id",           limit: 4
    t.boolean  "encrypt?"
    t.string   "encryption_key",      limit: 255
    t.string   "algorithm",           limit: 255
    t.boolean  "destroy_plaintext?"
    t.string   "storage_location",    limit: 255
    t.boolean  "stored_in_database?"
    t.boolean  "mongostore?"
  end

  create_table "urls", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "name",         limit: 255
    t.string   "locator",      limit: 255
    t.integer  "ip_id",        limit: 4
    t.string   "uri",          limit: 255
    t.string   "webserver",    limit: 255
    t.string   "dns",          limit: 255
    t.boolean  "stale?"
    t.datetime "last_crawled"
    t.string   "description",  limit: 255
    t.text     "content",      limit: 65535
    t.integer  "spyder",       limit: 4
    t.string   "backend",      limit: 255
  end

  create_table "userlogs", force: :cascade do |t|
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "username",    limit: 255
    t.string   "description", limit: 255
    t.datetime "lastlog"
    t.boolean  "loggedin?"
    t.integer  "sessions",    limit: 4
    t.integer  "gid",         limit: 4
    t.boolean  "sudo?"
    t.integer  "machine_id",  limit: 4
    t.integer  "user_id",     limit: 4
  end

  create_table "usernames", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password", limit: 255
    t.string   "email",              limit: 255
    t.string   "hashed_password",    limit: 255
    t.string   "key",                limit: 255
    t.string   "workstation",        limit: 255
    t.string   "authorization",      limit: 255
    t.string   "auth_method",        limit: 255
    t.string   "salt",               limit: 255
    t.string   "name",               limit: 255
    t.string   "fullname",           limit: 255
    t.string   "username",           limit: 255
    t.integer  "server_id",          limit: 4
    t.integer  "machine_id",         limit: 4
    t.integer  "database_id",        limit: 4
    t.integer  "table_id",           limit: 4
    t.integer  "upload_id",          limit: 4
    t.string   "phone",              limit: 255
    t.string   "lastlog_ip",         limit: 255
    t.datetime "lastlog"
    t.boolean  "logged_in?"
    t.string   "country",            limit: 255
    t.string   "company",            limit: 255
    t.integer  "infrastructure_id",  limit: 4
    t.integer  "network_id",         limit: 4
    t.integer  "cluster_id",         limit: 4
    t.string   "pki",                limit: 255
    t.string   "key_type",           limit: 255
    t.integer  "pubkey_id",          limit: 4
    t.integer  "privkey_id",         limit: 4
    t.integer  "group_id",           limit: 4
    t.integer  "access_level",       limit: 4
    t.boolean  "developer?"
    t.boolean  "operator?"
    t.boolean  "appop?"
    t.boolean  "admin?"
    t.integer  "operations_id",      limit: 4
    t.integer  "devops_id",          limit: 4
    t.integer  "developent_id",      limit: 4
    t.integer "role_id"
    t.integer  "research_id",        limit: 4
    t.string   "job_title",          limit: 255
    t.string   "job_requirements",   limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "secondary_email",        limit: 255
    t.string   "hashed_password",        limit: 255
    t.string   "key",                    limit: 255
    t.string   "workstation",            limit: 255
    t.string   "authorization",          limit: 255
    t.string   "auth_method",            limit: 255
    t.string   "salt",                   limit: 255
    t.string   "name",                   limit: 255
    t.string   "fullname",               limit: 255
    t.string   "username",               limit: 255
    t.string   "address1",               limit: 255
    t.string   "address2",               limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "zip",                    limit: 255
    t.string   "phone",                  limit: 255
    t.string   "lastlog_ip",             limit: 255
    t.datetime "lastlog"
    t.boolean  "logged_in?"
    t.string   "country",                limit: 255
    t.string   "company",                limit: 255
    t.integer  "infrastructure_id",      limit: 4
    t.integer  "network_id",             limit: 4
    t.integer  "cluster_id",             limit: 4
    t.integer  "database_id",            limit: 4
    t.integer  "table_id",               limit: 4
    t.integer  "upload_id",              limit: 4
    t.string   "pki",                    limit: 255
    t.string   "key_type",               limit: 255
    t.integer  "pubkey_id",              limit: 4
    t.integer  "privkey_id",             limit: 4
    t.integer  "group_id",               limit: 4
    t.integer  "access_level",           limit: 4
    t.boolean  "developer?"
    t.boolean  "operator?"
    t.boolean  "appop?"
    t.boolean  "admin?"
    t.integer  "operations_id",          limit: 4
    t.integer  "devops_id",              limit: 4
    t.integer  "developent_id",          limit: 4
    t.integer  "research_id",            limit: 4
    t.string   "job_title",              limit: 255
    t.string   "job_requirements",       limit: 255
    t.integer  "member_id",              limit: 4
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string "role"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "vfilesystems", force: :cascade do |t|
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "name",                   limit: 255
    t.string   "cluster_membership",     limit: 255
    t.boolean  "sharded?"
    t.integer  "replicas",               limit: 4
    t.integer  "cluster_size",           limit: 4
    t.float    "relative_data_safety",   limit: 24
    t.integer  "database_id",            limit: 4
    t.integer  "table_id",               limit: 4
    t.string   "path",                   limit: 255
    t.string   "location",               limit: 255
    t.integer  "size",                   limit: 4
    t.integer  "criticality",            limit: 4
    t.boolean  "encrypted?"
    t.integer  "infrastructure_id",      limit: 4
    t.integer  "cluster_id",             limit: 4
    t.integer  "server_id",              limit: 4
    t.string   "crypto_algorithm",       limit: 255
    t.integer  "bitstrength",            limit: 4
    t.integer  "relative_security",      limit: 4
    t.integer  "est_effective_lifespan", limit: 4
    t.integer  "rekey_period",           limit: 4
  end

  create_table "videos", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.string   "path",        limit: 255
    t.string   "type",        limit: 255
    t.string   "description", limit: 255
    t.integer  "size",        limit: 4
    t.binary   "silo",        limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "virtual_appliances", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "description",            limit: 255
    t.text     "details",                limit: 65535
    t.boolean  "pagefusion"
    t.integer  "memory_ballon",          limit: 4
    t.string   "macaddress1",            limit: 255
    t.string   "network_type",           limit: 255
    t.string   "ip",                     limit: 255
    t.string   "hostname",               limit: 255
    t.string   "version",                limit: 255
    t.string   "product_name",           limit: 255
    t.string   "product_url",            limit: 255
    t.string   "company_name",           limit: 255
    t.string   "company_url",            limit: 255
    t.string   "vserver_name",           limit: 255
    t.integer  "cpus",                   limit: 4
    t.integer  "ram",                    limit: 4
    t.integer  "disk",                   limit: 4
    t.boolean  "fixed_disk?"
    t.string   "application",            limit: 255
    t.datetime "release_date"
    t.boolean  "datastore?"
    t.boolean  "application?"
    t.boolean  "infrastructure?"
    t.boolean  "development?"
    t.boolean  "management?"
    t.boolean  "load_balancer?"
    t.boolean  "router?"
    t.boolean  "webserver?"
    t.string   "default_username",       limit: 255
    t.string   "default_password",       limit: 255
    t.boolean  "provisioned_with_chef?"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  create_table "webpages", force: :cascade do |t|
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "url",          limit: 255
    t.string   "title",        limit: 255
    t.string   "matches",      limit: 255
    t.datetime "last_crawled"
    t.boolean  "stale?"
    t.string   "referrer",     limit: 255
    t.integer  "spyder_id",    limit: 4
    t.integer  "url_id",       limit: 4
  end

  create_table "webservers", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "name",            limit: 255
    t.string   "service",         limit: 255
    t.string   "description",     limit: 255
    t.string   "hostname",        limit: 255
    t.integer  "criticality",     limit: 4
    t.integer  "priority",        limit: 4
    t.string   "organization",    limit: 255
    t.string   "isp",             limit: 255
    t.string   "status",          limit: 255
    t.string   "ip",              limit: 255
    t.string   "dns",             limit: 255
    t.string   "owner",           limit: 255
    t.text     "whois",           limit: 65535
    t.text     "details",         limit: 65535
    t.boolean  "secure?"
    t.string   "url",             limit: 255
    t.string   "secure_url",      limit: 255
    t.boolean  "up?"
    t.string   "provides",        limit: 255
    t.string   "uri",             limit: 255
    t.string   "api",             limit: 255
    t.boolean  "restful?"
    t.integer  "pubserver_id",    limit: 4
    t.integer  "organization_id", limit: 4
    t.integer  "reputation_id",   limit: 4
    t.integer  "url_id",          limit: 4
    t.integer  "server_id",       limit: 4
    t.integer  "port",            limit: 4
    t.text     "configuration",   limit: 65535
  end

  create_table "whoises", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "url_id",       limit: 4
    t.string   "hostname",     limit: 255
    t.string   "ip",           limit: 255
    t.integer  "ip_id",        limit: 4
    t.text     "content",      limit: 65535
    t.datetime "last_crawled"
  end

  create_table "words", force: :cascade do |t|
    t.string "stem", limit: 255
  end

end
