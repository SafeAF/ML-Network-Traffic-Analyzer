class Notification < ActiveRecord::Base
  belongs_to :machine
  belongs_to :user
  belongs_to :server
  belongs_to :cluster
  belongs_to :service
  belongs_to :application
end
