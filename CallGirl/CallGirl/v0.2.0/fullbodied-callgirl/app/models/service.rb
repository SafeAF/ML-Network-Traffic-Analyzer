  class Service <  ActiveRecord::Base
  # include Mongoid::Document
  # field :name, type: String
  # field :description, type: String
  # field :type, type: String
  # field :location, type: String
  # field :server_id, type: Integer
  # field :webserver_id, type: Integer
  # field :cluster_id, type: Integer
  # field :user_id, type: Integer
  # field :distribution, type: String
  # field :cluster, type: String
  # field :replication, type: String
  # field :authority, type: String
  # field :purpose, type: String
  # field :watchdog, type: String
  # field :pid, type: Integer
  # field :criticality, type: Integer
  # field :priority, type: Integer
  # field :network_id, type: Integer
  # field :manager_id, type: Integer
  # field :devops_id, type: Integer
  # field :configuration, type: String



  belongs_to :machine
  belongs_to :server
  belongs_to :node
belongs_to :user
belongs_to :cluster
has_many :statistics
  has_many :configurations
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

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}"])
    else
      self.all
    end
  end

end
