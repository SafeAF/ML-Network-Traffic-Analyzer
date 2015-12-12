class Application  < ActiveRecord::Base
  include Redis::Objects
  value :state
  value :pid
  list :file_descriptors
  list :log_file
  list :error_log
  list :rconnections

  has_many :connections
  has_many :processes
  has_many :configurations

  # include Mongoid::Document
  # field :name, type: String
  # field :purpose, type: String
  # field :description, type: String
  # field :hostname, type: String
  # field :parent_process, type: String
  # field :process_id, type: Integer
  # field :service, type: String
  # field :notice, type: String
  # field :node_id, type: Integer
  # field :criticality, type: Integer
  # field :priority, type: Integer
  # field :machine_id, type: Integer
  # field :server_id, type: Integer
  # field :user_id, type: Integer
  # field :network, type: String
  # field :network_id, type: Integer
  # field :manager_id, type: Integer
  # field :status, type: String
  # field :developer_id, type: Integer
  # field :pubserver_id, type: Integer

    def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}"])
    else
      self.all
    end
  end
end
