class Database < ActiveRecord::Base
  belongs_to :server
  belongs_to :machine
  belongs_to :cluster
  belongs_to :service
  belongs_to :application
  belongs_to :infrastructure
  belongs_to :network
  belongs_to :devops
end
