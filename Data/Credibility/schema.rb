# encoding: UTF-8
# Titan infrastruture DB
# Supermodels gem
# Seeds.rb Schema.rb DBIAPI.rb
  # version 0.3.0

  ActiveRecord::Schema.define(version: 000400) do

    create_table "admins", force: :cascade do |t|
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
    end

    create_table "bans", force: :cascade do |t|
      t.text :cereal
      t.text :banhistory
      t.text :banevents
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.float "dataup"
      t.float "datadown"
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
      t.text :cereal
    end

    create_table "databases", force: :cascade do |t|
      t.datetime "created_at",                    null: false
      t.datetime "updated_at",                    null: false
      t.string   "name",              limit: 255
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
      t.string :parent
      t.string :children
    end

    create_table "strategies", force: :cascade do |t|
      t.text :cereal

    end

    create_table "domainnames", force: :cascade do |t|
      t.string "name"
      t.string "hostname"
      t.string "reverselookup"
      t.string "nameserver1"
      t.string "nameserver2"
      t.integer "ip_id"
      t.text :cereal
    end

    create_table "sshpubkeys", force: :cascade do |t|
      t.integer :username_id
      t.integer :user_id
      t.integer :group_id
      t.string "fingerprint"
      t.text :pubkey
      t.text :privkey
      t.string :bits
      t.string :algorithm
      t.text :cereal
    end
    create_table "sshprivkeys", force: :cascade do |t|
       t.integer :username_id
      t.integer :user_id
      t.integer :group_id
      t.string "fingerprint"
      t.text :pubkey
      t.text :privkey
      t.string :bits
      t.string :algorithm
       t.text :cereal
    end

    create_table "domainnames", force: :cascade do |t|
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
      t.integer "organisation_id"
          t.integer "network_id"
      t.integer "server_id"
      t.string "nameserver1"
      t.string "nameserver2"
      t.text :cereal

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
      t.text :cereal
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
      t.string :gridid
      t.text :cereal
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
      t.text :cereal
      t.string :gridid
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
      t.text :cereal
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
      t.integer  "member_id",   limit: 4
      t.string   "name",        limit: 255
      t.integer  "total_files", limit: 4
      t.string   "description", limit: 255
      t.integer  "total_size",  limit: 4
      t.integer  "github_id",   limit: 4
      t.string :url
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
      t.integer  "username_id",           limit: 4
      t.integer :member_id
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
      t.text :cereal
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


      t.text   "jsonservices",                      limit: 255
      t.text   "jsonapplications",                  limit: 255
      t.text "jsonservers"
      t.text "cereal"
      t.integer  "cluster_id",                   limit: 4
      t.integer  "username_id",                      limit: 4
      t.integer  "criticality",                  limit: 4
      t.string   "network",                      limit: 255
      t.integer  "admin_id",                     limit: 4
      t.integer  "operations_id",                limit: 4
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
      t.integer  "domainname_id",          limit: 4
      t.integer  "organization_id", limit: 4
      t.integer "credibility_id"
      t.text :cereal
      t.integer :weight
      t.integer :credibility
      t.text :scanresult
      t.boolean :banned
      t.string :location


    end

    create_table "issuelists", force: :cascade do |t|
      t.string   "name",        limit: 255
      t.string   "description", limit: 255
      t.integer  "project_id",  limit: 4
      t.integer "department_id"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.text :cereal
    end

    create_table "issues", force: :cascade do |t|
      t.string   "name",       limit: 255
      t.string   "author",     limit: 255
      t.string   "assignee",   limit: 255
      t.integer "project_id"
      t.string "description"
      t.text "content"
      t.integer "department_id"
      t.integer "infrastructure_id"
      t.integer "operations_id"
      t.integer "username_id"
      t.integer  "user_id",    limit: 4
      t.string   "labels",     limit: 255
      t.integer  "label_id",   limit: 4
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
      t.text :cereal
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
      t.string  "label",        limit: 255
      t.integer "issue_id",     limit: 4
      t.integer "milestone_id", limit: 4
      t.string :header
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
      t.text :training_data
      t.float :efficiency
      t.float :false_positives
      t.float :false_negatives
      t.text :serialized_neural
      t.text :config
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
      t.text :cereal
      t.text :config
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

      t.string   "encrypted_password", limit: 255
      t.string   "hashed_password",    limit: 255
      t.string   "key",                limit: 255
      t.string   "salt",               limit: 255
      t.string   "nickname",               limit: 255
      t.string   "fullname",           limit: 255
      t.string   "username",           limit: 255
      t.string   "address1",           limit: 255
      t.string   "address2",           limit: 255
      t.string   "city",               limit: 255
      t.string   "state",              limit: 255
      t.string   "zip",                limit: 255
      t.string   "phone",              limit: 255
      t.string   "lastlog_ip",         limit: 255

      t.string   "country",            limit: 255
      t.string   "company",            limit: 255
      t.string   "job_title",          limit: 255
      t.text "sshpubkey"
      t.text "sshprivkey"
      t.text :cereal
      t.datetime "lastlog"
      t.boolean  "logged_in?"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table "loginrecord", force: cascade do |t|
      t.string :username
      t.string :fromhost
      t.string :hostname
      t.string :fromip
      t.string :localip
      t.string :tty
      t.datetime :when
      t.datetime :whenlast
      t.integer :member_id
      t.integer :user_id
      t.text :command_history_json
      t.float :idle
      t.float :jcpu
      f.float :pcpu
      t.string :what
      t.text :owned_processes_json
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
      t.text :cereal
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
      t.integer "memberid", limit:4
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
      t.text :cereal
    end

    create_table "milestones", force: :cascade do |t|
      t.datetime "created_at",               null: false
      t.datetime "updated_at",               null: false
      t.string   "name",       limit: 255
      t.string   "heading",    limit: 255
      t.text     "body",       limit: 65535
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
      t.string "netmask"
      t.string "network"
      t.string "subnet"
      t.integer "usernames_id"
      t.integer "total_nodes"
      t.integer "nodes_alive"
      t.float "average_latency"
      t.float "health"
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.float "manhours_per_day"
      t.float "manhours_average_day"
      t.float "effectiveness"
      t.float "utilization"
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


    create_table "pids", force: :cascade do |t|
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
      t.string "topic"
      t.text     "details",               limit: 65535
      t.integer  "infrastructure_id",     limit: 4
      t.integer  "research_id",           limit: 4
      t.integer  "developer_id",          limit: 4
      t.integer  "organization_id"
      t.integer  "application_id",        limit: 4
      t.float "completion_percentage"
      t.float "percentage_difference_from_projected"
      t.datetime "projected_completion"
      t.datetime  "expected_completion"
      t.integer "team_size"
      t.integer  "username_id",           limit: 4
      t.integer  "user_id",               limit: 4
      t.integer  "member_id",             limit: 4
      t.integer  "manhours",              limit: 4
      t.integer  "eta",                   limit: 4
      t.float    "completion_percentage", limit: 24

  t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
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
      t.text :cereal
    end

    create_table "queques", force: :cascade do |t|
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.string   "name",        limit: 255
      t.integer  "critlarm_id", limit: 4
      t.text :cereal
      t.integer :notification_id
      t.integer :alert_id
      t.integer :message_id
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
      t.integer "domain_id"
      t.text :cereal
      t.integer :weight
      t.float :credibility


      t.float "confidence"
      t.string "description"
      t.integer  "value",      limit: 4
    end

    create_table "reputationlogs", force: :cascade do |t|

      t.integer "ip_id"
      t.text  "precipitating_event"
      t.string "url"
      t.string "source"
      t.datetime
      t.text :cereal
      t.integer "modifier"
      t.string "description"
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
      t.text :cereal
    end

    create_table "credibilities", force: :cascade do |t|
      t.datetime
      t.text :cereal
      t.string "name"
      t.string "description"
      t.integer "ip_id"
      t.integer "domain"
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
      t.integer  "infrastructure_id",    limit: 4
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
      t.text :cereal
      t.text :loginkey
      t.text :jsonfiles
      t.text :jsondatabases
      t.text :jsonconnections
      t.text :jsonservices
      t.text :jsonpids
      t.text :jsoninfo
      ttext :jsonvitals
      t.text     "configuration", limit: 65535
    end

    create_table "nodes", force: :cascade do |t|
      t.datetime :created_at
      t.datetime :updated_at
          t.string :name
          t.string :username
          t.string :password
          t.string :apiuser
          t.string :apikey
          t.text :privkey
          t.text :pubkey
          t.string :ip
      t.text :cereal
          t.text :key
          t.string :hostname
          t.string :cluster
          t.string :organization
          t.integer :user_id
                    t.integer :uuid
          t.boolean :virtual
          t.boolean :installed
          t.boolean :subscribed
          t.integer :uptime
          t.text :configuration
          t.string :service
          t.string :os
          t.integer :ipaddr
          t.boolean :up

    end

    create_table "instancelogfilters", force: :cascade do |t|
      t.string :name
          t.string :filter
      t.integer :priority
      t.string :description
               t.string :service
          t.integer :instance_id
      t.text :cereal
    end

    create_table "instances", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "instance_type",  limit: 255
      t.string   "gucid",          limit: 255
      t.string :log_path
               t.string :pcap_log_path
                        t.string :simple_log_filter
      t.string :uuid
      t.integer :log_record_id

      t.string   "hostname",       limit: 255
      t.string   "facility",       limit: 255
      t.string   "extended_stats", limit: 255
      t.string   "ip",             limit: 255
      t.boolean  "subscribed?",                   default: false, null: false
      t.boolean  "installed?",                    default: false, null: false
      t.datetime "alive"
      t.string   "description",    limit: 255
      t.string   "human_name",     limit: 255
      t.integer  "server_id",      limit: 4
      t.integer  "node_id",      limit: 4
      t.integer  "machine_id",     limit: 4
      t.boolean  "aggregation",                  default: false
      t.integer  "extrainteger",   limit: 4
      t.boolean  "extraboolean?"
      t.string   "extrastring",    limit: 255
      t.text     "extratext",      limit: 65535
      t.text     "pcap_location",     limit: 65535
      t.text     "pcap_filter",       limit: 65535
      t.text     "pcap_interface",    limit: 65535
      t.integer  "update_flag",       limit: 4,     default: 0
      t.boolean  "stats_log?"
      t.boolean  "stats_pcap?"
      t.boolean  "monitor_log?"
      t.boolean  "monitor_pcap?"
      t.text :cereal
      t.text :jsonvitals
    end

    create_table "subscriptions", force: :cascade do |t|
      t.string :name
      t.string :description
      t.integer :duration_seconds
      t.float :duration
      t.datetime :incept_date
      t.datetime :expiration_date
      t.timestamps
      t.string :service
      t.integer :instance_id
      t.float :price_per_unit
      t.float :unit_size
      t.float :subscription_fee
      t.boolean :subscribed?
      t.boolean :active?
      t.datetime :last_seen
      t.integer :node_id

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
      t.integer "node_id"
      t.integer "server_id"
      t.text :cereal
      t.text     "instance_info",     limit: 65535
      t.integer  "extrainteger",      limit: 4
      t.boolean  "extraboolean?"
      t.string   "extrastring",       limit: 255
      t.text     "extratext",         limit: 65535
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
      t.text :cereal
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

    create_table "titanvservs", force: :cascade do |t|

      t.string :hostname
      t.string :ip
      t.string :purpose
      t.string :description
      t.text :details
      t.string :os

    end
    create_table "titanwebapps", force: :cascade do |t|
      t.string :name
      t.string :description
      t.string :path
      t.string :appname
      t.string :publicurl
      t.string :url
      t.string :deploymentstr
      t.string :launchstr
      t.text :configuration
      t.text :details
      t.integer :titanvserv_id
      t.string :language
      t.string :framework
      t.string :vhost
      t.string :server
      t.string :binarypath
      t.string :version
      t.text :files
      t.text :deps

    end

    create_table "titanprocesses", force: :cascade do |t|
      t.string :name
      t.string :description
      t.string :path
      t.string :appname
      t.text :openfilehandles
      t.integer :pid
      t.integer :titanservice_id

    end
    create_table "titanconnections", force: :cascade do |t|
      t.string :name
      t.string :description
      t.string :path
      t.string :appname
      t.string :source
      t.string :dest
      t.integer :sourceport
      t.integer :destport
t.float :sent
      t.float :recv
      t.integer :pid
      t.integer :titanservice_id
      end


    create_table "titanservices", force: :cascade do |t|
      t.string :name
      t.string :description
      t.string :path
      t.string :appname
     t.string :binarypath
      t.string :url
      t.string :deploymentstr
      t.string :launchstr
      t.text :configuration
      t.text :details
      t.text :files
      t.integer :titanvserv_id
      t.string :language
      t.string :framework
      t.string :vhost
      t.string :server
      t.string :version
    end

    create_table "diskdrives", force: :cascade do |t|
      t.string :dev
      t.string :mountpoint
      t.float :totalgb
      t.float :freegb
      t.float :usedgb
      t.float :percentused
      t.string :filesystem
      t.integer :titanvserv_id


    end
    create_table "installeddebs", force: :cascade do |t|
      t.string :name
      t.string :description
      t.integer :titanvserv_id
      t.string :binaryname
      t.text :binarieslist
      t.text :installedfiles
    end

    create_table "installedscripts", force: :cascade do |t|

    t.string :name
      t.string :description
      t.integer :titanvserv_id
      t.string :binaryname
    t.text :binarieslist
      t.text :installedfiles

    end

    create_table "statistics", force: :cascade do |t|
      t.datetime "created_at",                     null: false
      t.datetime "updated_at",                     null: false
      t.integer  "server_id",         limit: 4
      t.string   "value",              limit: 255
      t.integer  "quantity",           limit: 4
      t.float    "statistic",       limit: 24
   end

    create_table "advstatistics", force: :cascade do |t|
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

    create_table "logs", force: :cascade do |t|
      t.string :hostname
      t.text :message
      t.integer :facility
      t.integer :severity
      t.integer :criticality
      t.string :subsystem
      t.timestamps
    end

    create_table "syslogs", force: :cascade do |t|
      t.string :hostname
      t.text :message
      t.integer :facility
      t.integer :severity
      t.integer :criticality
      t.string :subsystem
      t.timestamps
    end

    create_table "applogs", force: :cascade do |t|
      t.string :hostname
      t.text :message
      t.integer :facility
      t.integer :severity
      t.integer :criticality
      t.string :subsystem
      t.timestamps
    end

    add_index :applogs, [:hostname, :facility, :severity]
    add_index :syslogs, [:hostname, :facility, :severity]
    add_index :logs, [:hostname, :facility, :severity,]

    create_table "prodlogs", force: :cascade do |t|
      t.string :hostname
      t.text :message
      t.integer :facility
      t.integer :severity
      t.integer :criticality
      t.string :subsystem
      t.timestamps
    end

    add_index :prodlogs, [:hostname, :facility, :severity]

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
      t.integer "project_id"
      t.integer "department_id"
      t.integer "infrastructure_id"
      t.integer "operations_id"
      t.integer "username_id"
      t.text     "body",        limit: 65535
      t.text     "content",     limit: 65535
      t.string   "header",      limit: 255
      t.string   "heading_one", limit: 255
      t.string   "heading_two", limit: 255
      t.integer  "project_id",  limit: 4
    end

    create_table "teams", force: :cascade do |t|
      t.string "name"
      t.string "description"
      t.integer "department_id"
      t.integer "project_id"
       t.integer "members"

    end

    create_table "todos", force: :cascade do |t|
      t.string   "name",                  limit: 255
      t.string   "desc",                  limit: 255
      t.datetime "eta"
      t.integer "project_id"
      t.integer "department_id"
      t.integer "infrastructure_id"
      t.integer "operations_id"
      t.integer "username_id"
      t.integer "team_id"
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
      t.text "log"
      t.boolean  "sudo?"
      t.integer  "machine_id",  limit: 4
      t.integer  "user_id",     limit: 4
    end

    create_table "departments", force: :cascade do |t|
      t.string "name"
      t.integer "organization"
      t.string "description"
      t.text "details"
    end

    create_table "usernames", force: :cascade do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.string   "encrypted_password", limit: 255
      t.string   "email",              limit: 255
      t.string   "hashed_password",    limit: 255
      t.string   "key",                limit: 255
      t.integer "project_id"
      t.integer "department_id"
      t.integer "infrastructure_id"
      t.integer "operations_id"
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
      t.integer "team_id"

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
      t.string "role"
      t.boolean  "developer"
      t.boolean  "operator"
      t.boolean  "appop?"
      t.boolean  "admin"
      t.integer  "operations_id",      limit: 4
      t.integer  "devops_id",          limit: 4
      t.integer  "developent_id",      limit: 4
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
      t.string   "pki",                    limit: 255
      t.string "keyfingerprint"
      t.string "shortkeyfingerprint"
      t.string   "key_type",               limit: 255
      t.integer  "pubkey_id",              limit: 4
      t.integer  "privkey_id",             limit: 4
      t.integer  "group_id",               limit: 4
      t.integer  "access_level",           limit: 4
      t.boolean  "developer"
      t.boolean  "operator"
      t.boolean  "appop?"
      t.boolean  "admin"
      t.integer  "operations_id",          limit: 4
      t.integer  "devops_id",              limit: 4
      t.integer  "developent_id",          limit: 4
      t.integer  "research_id",            limit: 4
      t.string   "job_title",              limit: 255
      t.string   "job_requirements",       limit: 255
      t.integer "organization_id"
      t.integer "upload_id"
      t.integer "dashboard_id"
      t.integer "admin_id"
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
#
#   create_table "users", force: :cascade do |t|
#   t.string   "email",                  default: "", null: false
#   t.string   "encrypted_password",     default: "", null: false
#   t.string   "reset_password_token"
#   t.datetime "reset_password_sent_at"
#   t.datetime "remember_created_at"
#   t.integer  "sign_in_count",          default: 0,  null: false
#   t.datetime "current_sign_in_at"
#   t.datetime "last_sign_in_at"
#   t.string   "current_sign_in_ip"
#   t.string   "last_sign_in_ip"
#   t.datetime "created_at"
#   t.datetime "updated_at"
#   t.string   "name"
#   t.integer  "role"
# end

#add_index "users", ["email"], name: "index_users_on_email", unique: true
#add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
