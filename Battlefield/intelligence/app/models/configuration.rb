class Configuration < ActiveRecord::Base
  belongs_to :machine
  belongs_to :server
  belongs_to :application
  belongs_to :service
end
