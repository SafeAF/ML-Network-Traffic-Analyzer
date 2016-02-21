class Server <  ActiveRecord::Base
# include Mongoid::Document
  include Redis::Objects
  # include Mongoid::Document
  # field :name, type: String
  # field :username, type: String
  # field :password, type: String
  # field :privkey, type: String
  # field :pubkey, type: String
  # field :key, type: String
  # field :ip, type: String
  # field :hostname, type: String
  # field :cluster, type: String
  # field :ipaddr, type: Integer
  # field :type, type: String
  # field :string, type: String
  # field :machine_id, type: Integer
  # field :cluster_id, type: Integer
  # field :virtual?, type: Mongoid::Boolean
  # field :up?, type: Mongoid::Boolean
  # field :criticality, type: Integer
  # field :priority, type: Integer
  # field :network_id, type: Integer
  # field :manager_id, type: Integer
  # field :os, type: String
  # field :devops_id, type: Integer
  # field :uptime, type: Integer
  # field :system_id, type: Integer
  # field :user_id, type: Integer
  # field :configuration, type: String




  hash_key :logged_in_users
  hash_key :last_logged

  belongs_to :user
  has_many :services  #, :autosave => true
  has_many :applications
  has_many :processes
  belongs_to :cluster
  has_many :statistics
  belongs_to :network
  has_many :configurations

  has_many :statistics
#  belongs_to :machine
  has_many :nodes
  has_many :applications
  has_many :processes
  has_many :connections
  has_many :harddisks
  has_many :logfiles
  belongs_to  :manager
  belongs_to :network
  belongs_to :infrastructure
  has_many :messages
  has_many :notifications
  has_many :services
  has_many :applications

  # def self.search(search)
  #   if search
  #     find(:all, :conditions => ['name LIKE ?', "%#{search}"])
  #   else
  #     self.all
  #   end
  # end


end
