class Pid < ActiveRecord::Base
  belongs_to :machine
  belongs_to :server
  belongs_to :node
  belongs_to :network
  belongs_to :manager
  belongs_to :application
  belongs_to :service
end
