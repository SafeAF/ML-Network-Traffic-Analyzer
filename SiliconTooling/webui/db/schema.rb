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

	create_table "audittrails", force: true do |t|
		t.integer "logofusers_id"
		t.string "username"
		t.string "description"
		t.text "audit_trail"
		t.boolean "sudo?"
		t.boolean "su?"
		t.datetime "occurred_at"
		t.string "filename"
		t.string "machine"
		t.string "command"
		t.integer "occurances"
		t.integer "failures"
		t.integer "successes"
		t.integer "returncode"
		t.boolean "succeeded?"
		t.string "log_location"
		t.boolean "logged?"
		t.integer "user_id"
		t.integer "machine_id"
		t.integer "gid"
	end

	create_table "application", force: true do |t|
		t.string "name"
		t.string "purpose"
		t.string "description"
		t.string "hostname"
		t.string "parent_process"
		t.integer "process_id"
		t.string "service"
		t.string "notice"
		t.integer "node_id"
		t.integer "criticality"
		t.integer "priority"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "user_id"
		t.string "network"
		t.integer "network_id"
		t.integer "manager_id"
		t.integer "user_id"
		t.string "development_status"
		t.integer "developer_id"


	end



  create_table "bans", force: true do |t|
    t.string   "ip"
    t.string   "srcip"
    t.string   "srcport"
    t.string   "destip"
    t.string   "srcport"
    t.string   "protocol"
    t.string   "service"
    t.string   "cid"
    t.string   "user"
    t.string   "geo"
    t.integer  "reputation"
    t.integer  "change_in_reputation"
    t.integer "prev_reputation"
    t.boolean "externally_known_bad?"
    t.string  "other_source"
    t.string  "other_source2"
    t.integer  "other_source_reputation"
    t.integer  "other_source2_reputation"
    t.float    "rep"
    t.string   "priority"
    t.string   "facility"
    t.boolean   "from_pcap?", default: false
    t.datetime "occurred_at"
    t.datetime "last_seen"
    t.datetime "first_seen"
    t.boolean "valid_reverse_lookup"
    t.datetime "last_validated"
    t.string   "source_file_path"
    t.string   "client_hostname"
    t.integer  "duration"
    t.string   "gucid"
    t.integer  "machine_id"
    t.integer "server_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "host_lookup", default: "UNKNOWN"
    t.string   "location",    default: "UNKNOWN"
    t.text     "reason"
	  t.string   "extrastring"
	  t.boolean  "extraboolean?"
	  t.text     "extratext"
	  t.integer  "extrainteger"
	  t.float    "extrafloat"
	  t.string   "botnet_membership"
	  t.string   "isp"
	  t.string "network"
	  t.integer "network_id"

  end

	create_table "cluster", force: true do |t|
		t.integer "user_id"
		t.string "name"
		t.string "cluster_type"
		t.integer "members"
		t.string "resource_manager"
		t.text  "information"
		t.string "status"
		t.text "details"

	end



	create_table "connections", force: true do |t|
		t.string "name"
		t.string "description"
		t.string "program"
		t.string "status"
		t.boolean "open?", default: false
		t.string "protocol"
		t.integer "proto"
		t.string "srcip"
		t.string "destip"
		t.string "srcport"
		t.string "dstport"
		t.boolean "listener?", default: false
		t.integer "pid"
		t.integer "recv"
		t.integer "sent"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "service_id"
		t.integer "process_id"
		t.integer "pid"
		t.string "filehandle"
		t.integer "network_id"
	end



	create_table "databases", force: true do |t|
		t.string "name"
		t.string "hostname"
		t.string "cluster"
		t.string "type"
		t.string "db"
		t.integer "count"
		t.string "user"
		t.string "password"
		t.string "connection_string"
		t.integer "server_id"
		t.integer "machine_id"
		t.integer "cluster_id"
		t.integer "service_id"
		t.integer "application_id"
		t.integer "infrastructure_id"
		t.string "status"
		t.string "purpose"
		t.integer "criticality"
		t.integer "priority"
		t.integer "network_id"
		t.integer "devops_id"
	end


	create_table "groups", force: true do |t|
		t.string "name"
		t.integer "user"
		t.integer "machine_id"
		t.integer "server_id"
		t.string "purpose"
		t.datetime "incept_date"
		t.integer "access_level"
	end



  create_table "logofusers", force: true do |t|
	  t.string "username"
	  t.string "description"
	  t.datetime "lastlog"
	  t.boolean "loggedin?"
	  t.integer "sessions"
	  t.integer "gid"
	  t.boolean "sudo?"
	  t.integer "machine_id"
	  t.integer "user_id"

  end



	create_table "devops", force: true do |t|
		t.string "name"
		t.string "description"
		t.integer "user_id"
		t.integer "server_id"
		t.integer "service_id"
		t.integer "machine_id"
		t.integer "database_id"

		t.string "job_title"
		t.string "job_description"
	end



	create_table "developers", force: true do |t|
		t.string "name"
		t.string "description"
		t.integer "user_id"
		t.string  "skill_level"
		t.string "languages"
		t.text "skills"
		t.string "job_title"
		t.string "job_description"
	end

	create_table "directories", force: true do |t|
		t.string "name"
		t.integer "size"
		t.string "path"
		t.string "basepath"
		t.integer "permissions"
		t.integer "user_id"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "application_id"
		t.string "purpose"
		t.string "description"
		t.datetime "creation"
		t.datetime "modification"
		t.datetime "accessed"
		t.integer "group_id"
		t.integer "members"
		t.integer "harddrive_id"
		t.string "houses"
		t.string "role"

	end


	create_table "files", force: true do |t|
		t.string "name"
		t.string "extension"
		t.integer "size"
		t.string "path"
		t.string "basepath"
		t.integer "permissions"
		t.integer "user_id"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "application_id"
		t.integer "process_id"
		t.string "filetype"
		t.string "purpose"
		t.string "description"
		t.datetime "creation"
		t.datetime "modification"
		t.datetime "accessed"
		t.integer "group_id"
		t.integer "directory_id"
		t.string "role"
	end

  create_table "process", force: true do |t|

	  t.string "name"
	  t.integer "pid"
	  t.string "process"
	  t.string "path"
	  t.float "proctime"
	  t.float "walltime"
	  t.float "io"
	  t.float "iowait"
	  t.float "memory"
	  t.integer "machine_id"
	  t.integer "server_id"
	  t.integer "node_id"
	  t.integer "network_id"
	  t.integer "manager_id"
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
	  t.text    "instance_info"
	  t.integer "extrainteger"
	  t.boolean  "extraboolean?"
	  t.string  "extrastring"
	  t.text    "extratext"
  end

  create_table "instances", force: true do |t|
    t.string   "instance_type"
    t.string   "gucid"
    t.string   "hostname"
    t.string   "facility"
    t.string   "extended_stats"
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
    t.integer "extrainteger"
    t.boolean  "extraboolean?"
    t.string  "extrastring"
    t.text    "extratext"
	  t.float   "extrafloat"
  end



	create_table "infrastructure", force: true do |t|
		t.string "name"
		t.string "purpose"
		t.string "description"
		t.string "type"
		t.string "effectiveness"
		t.string "service"
		t.string "application"
		t.integer "cluster_id"
		t.integer "user_id"
		t.integer "criticality"
		t.string "network"
		t.integer "operations_id"
	end

	create_table "items", force: true do |t|
		t.integer "quantity"
		t.string "name"
		t.string "desc"
		t.string "value"
		t.float "quan"
		t.float "amount"
		t.integer "priority"
		t.integer "inventory_id"
	end

  create_table "harddrives", force: true do |t|
	  t.string "name"
	  t.string "description"
	  t.string "mount_point"
	  t.string "device"
	  t.string "UUID"
	  t.float "available"
	  t.float "size"
	  t.float "used"
	  t.float "percent_used"
	  t.string "filesystem"
	  t.integer "machine_id"
	  t.integer "criticality"
	  t.integer "server_id"
	  t.integer "infrastructure_id"
	  t.string  "raid"
	  t.string  "drive_type"
	  t.string "drive_interface"
	  t.boolean "external?"

  end


	create_table "hardwares", force: true do |t|
		t.string "name"
		t.integer "user_id"
		t.integer "machine_id"
	  t.integer "inventory_id"
		t.integer "operations_id"
		t.string "type"
		t.string "purpose"
		t.string "identifier"
		t.string "size"
		t.string "description"
		t.text "details"
	end

  create_table "logfiles", force: true do |t|
    t.integer "machine_id"
    t.string "name"
    t.string "description"
    t.float "size"
	  t.integer "entries"
	  t.string "location"
	  t.string "path"
	  t.string "basename"
	  t.string "service"
	  t.integer "service_id"
	  t.integer "server_id"
	  t.integer "criticality"
  end

  create_table "logentries", force: true do |t|
    t.integer "logfile_id"
    t.string "name"
	  t.text "message"
	  t.string "facility"
	  t.integer "priority"
	  t.datetime "logged_at"
	  t.string "service"
    t.integer "service_id"
	  t.integer "logentry_id"
  end

 # add_index "logentries", ["logentry_id"], name: "index_logentry_on_logentry_id", using: :btree
 # add_index "logentries", ["updated_at"], name: "index_logentry_on_updated_at", using: :btree


	create_table "networks", force: true do |t|
		t.string "name"
		t.string "purpose"
		t.string "type"
		t.integer "speed"
		t.integer "infrastructure_id"
		t.string "ownership"
		t.string "netadmin"
		t.integer "user_id"
		t.integer "cluster_id"
		t.string "gateway_ip"
		t.string "router_ip"
		t.string "broadcast"
		t.string "address_space"
		t.string "dns"
		t.string "ptr_record"
		t.string "a_record"
		t.string "reverse_address"
		t.integer "network_box"
		t.integer "operations_id"
	end

	create_table "network_boxes", force: true do |t|
		t.string "name"
		t.string "hostname"
		t.string "ip"
		t.string "type"
		t.string "manufacturer"
		t.string "model"
		t.string "router"
		t.string "gateway"
		t.integer "network_id"
		t.integer "infrastructure_id"
		t.string "gateway_ip"
		t.string "os"
		t.integer "operations_id"



	end
	create_table "nodes", force: true do |t|
    t.string "name"
	  t.integer "server_id"
	  t.string "hostname"
	  t.string "ip"
	  t.integer "ipaddr"
	  t.integer "machine_id"
	  t.string "value"
	  t.float "quantity"
	  t.integer "number"
	  t.integer "manager_id"
		t.string "os"
		t.integer "devops_id"
	end


	create_table "notifications", force: true do |t|
		t.integer "machine_id"
		t.integer "user_id"
		t.string  "message"
		t.integer "priority"
		t.string "source"
		t.string "destination"
		t.integer "cluster_id"
		t.integer "service_id"
		t.integer "application_id"
	end

	create_table "machines", force: true do |t|
		t.string   "name"
		t.string "executor"
		t.string "remote_execution"
		t.boolean "remote_execution_capability?"
		t.integer  "user_id"
		t.integer "cluster_id"
		t.string   "cid",       default: "none"
		t.string   "ip"
		t.string   "hostname"
		t.string   "physical_host"
		t.string   "is_virtual?", default: true
		t.integer  "ram"
		t.integer  "cpus"
		t.integer  "ghz"
		t.string   "cputype"
		t.integer "ipaddr"
		t.string   "available_disk_slots"
		t.string   "total_disk_slots"
		t.string   "pci_express_expansion0"
		t.string   "pci_express_expansion1"
		t.integer   "pci_express_slots"
		t.integer   "pci_express_available"
		t.string   "ram_type"
		t.string    "ram_speed"
		t.integer   "total_ram_slots"
		t.integer   "available_ram_slots"
		t.integer   "ram_available"
		t.integer   "ram_cached"
		t.integer   "ram_buffers"
		t.integer   "ram_swap"
		t.float     "load1m"
		t.float     "load5m"
		t.float     "load15m"
		t.string    "type_of_storage"
		t.string    "external_storage"
		t.string    "raid"
		t.integer   "disk_total"
		t.integer   "disk_avail"
		t.integer   "disk_used"
		t.integer   "listeners"
		t.integer   "established"
		t.text      "network_connections"
		t.string    "node_name"
		t.string     "cluster"
		t.boolean  "installed", default: false
		t.datetime "alive"
		t.string   "status"
		t.integer  "health"
		t.integer "extrainteger"
		t.boolean  "extraboolean?"
		t.string  "extrastring"
		t.text    "extratext"
		t.float   "extrafloat"
		t.string  "silicond"
		t.string  "highwayd"
		t.string  "emdaemon"
		t.string  "processing_uri"
		t.boolean "master?"
		t.integer "network_id"
		t.integer "manager_id"
		t.string "os"
		t.integer "devops_id"
	end

	create_table "managers", force: true do |t|
		t.string "name"
		t.string "purpose"
		t.string "resources"
		t.string "hostname"
		t.integer "infrastructure_id"
		t.integer "cluster_id"
		t.string "management_software"

	end


	create_table "messages", force: true do |t|
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "application_id"
		t.integer "service_id"
		t.integer "process_id"
		t.integer "user_id"
		t.string  "message"
		t.string  "response"
		t.text    "body"
		t.string   "header"
		t.string  "type"
		t.string  "concerning"
		t.boolean "top_secret?"
		t.integer "priority"
		t.string "destination"
		t.string "source"
	end


	create_table "operations", force: true do |t|
		t.string "name"
		t.string "description"
		t.integer "user_id"
		t.integer "infrastructure_id"
		t.string "job_title"
		t.string "job_description"
	end

	create_table "projects", force: true do |t|
		t.string "name"
		t.string "description"
		t.text "details"
		t.integer "infrastructure_id"
		t.integer "research_id"
		t.integer "developer_id"
		t.integer "application_id"
		t.datetime "projected_completion"
		t.integer "manhours"
		t.float "completion_percentage"
	end

	create_table "pubkeys", force: true do |t|
		t.string "name"
		t.string "location"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "user_id"
		t.text "key"
		t.string "type"
		t.integer "bits"
		t.string "purpose"
		t.integer "keynumber"
		t.boolean "encryptor?"
		t.string "generator"
		t.datetime "expiration"
		t.string "keyserver"
	end

	create_table "privkeys", force: true do |t|
		t.string "name"
		t.string "location"
		t.integer "machine_id"
		t.integer "server_id"
		t.integer "user_id"
		t.text "key"
		t.string "type"
		t.integer "bits"
		t.string "purpose"
		t.integer "keynumber"
		t.boolean "encryptor?"
		t.string "generator"
		t.datetime "expiration"
		t.string "keyserver"
		t.boolean "high_security?"
	end

	create_table "pages", force: true do |t|
		t.string "name"
		t.string "header"
		t.text "body"
		t.text "content"
		t.string "title"
		t.string "subtitle"
		t.string "subheading"
		t.boolean "static?"
		t.string "page"
		t.integer "page_number"
		t.string "description"
		t.string "app_name"
	end

    create_table "servers", force: true do |t|
      t.string   "name"
      t.string "username"
      t.string "password"
      t.text "privkey"
      t.text "pubkey"
      t.text "key"
      t.string "ip"
      t.string "hostname"
      t.string "cluster"
      t.integer "ipaddr"
      t.string "type"
      t.integer "machine_id"
      t.integer "cluster_id"
      t.boolean "virtual?"
      t.boolean "up"
      t.string "cluster"
	    t.integer "criticality"
	    t.integer "priority"
	    t.integer "network_id"
	    t.integer "manager_id"
	    t.string "os"
	    t.integer "devops_id"


    end

  create_table "services", force: true do |t|
	  t.string "name"
	  t.string "description"
	  t.string "type"
	  t.string "location"
	  t.integer "server_id"
	  t.integer "machine_id"
	  t.integer "cluster_id"
	  t.integer "user_id"
	  t.string "distribution"
	  t.string "cluster"
	  t.string "replication"
	  t.string "authority"
	  t.string "purpose"
	  t.string "watchdog"
	  t.integer "pid"
	  t.integer "criticality"
	  t.integer "priority"
	  t.integer "network_id"
	  t.integer "manager_id"
	  t.integer "devops_id"
  end
	create_table "statistics", force: true do |t|
		t.integer "machine_id"
		t.string "name"
		t.string "description"
		t.string "value"
		t.boolean "active?"
		t.integer "quantity"
		t.float "rateofchange"
		t.integer "rate"
		t.integer "previous_qty"
		t.float "historical"
		t.float "historical_average"
		t.string "transport"
		t.float "amount"
		t.float "current_value"
		t.float "previous_value"
		t.float "percentage"
		t.integer "priority"
		t.integer "service_id"
		t.integer "user_id"
		t.integer "server_id"
		t.integer "application_id"
		t.integer "process_id"
		t.integer "network_id"
	end


	create_table "tables", force: true do |t|
	  t.string "name"
	  t.integer "rows"
	  t.string "columns"
	  t.integer "columns_count"
	  t.integer "application_id"
	  t.integer "database_id"
	  t.string "purpose"
	  t.integer "criticality"
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


	create_table "researches", force: true do |t|
		t.string "name"
		t.string "description"
		t.integer "user_id"
		t.integer "infrastructure_id"
		t.string "job_title"
		t.string "job_description"
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

 # add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
 # add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

 # add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "hashed_password"
    t.string   "key"
    t.string   "workstation"
    t.string   "authorization"
    t.string   "auth_method"
    t.string   "salt"
    t.string   "name"
    t.string   "fullname"
    t.string   "username"
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
	  t.integer "infrastructure_id"
	  t.integer "network_id"
	  t.integer "cluster_id"
	  t.string "pki"
	  t.string "key_type"
	  t.integer "pubkey_id"
	  t.integer "privkey_id"
    t.integer "group_id"
	  t.integer "access_level"
	  t.boolean "developer?"
	  t.boolean "operator?"
	  t.boolean "appop?"
	  t.boolean "admin?"
	  t.integer "operations_id"
	  t.integer "devops_id"
	  t.integer "developent_id"
	  t.integer "research_id"
	  t.string "job_title"
	  t.string "job_requirements"

  end

	    ### FINISH THIS ONE



	end




