class Service < ActiveRecord::Base
  belongs_to :server
  belongs_to :webserver
  belongs_to :machine
  belongs_to :cluster
  belongs_to :user
  belongs_to :network
  belongs_to :manager
  belongs_to :devops
end
