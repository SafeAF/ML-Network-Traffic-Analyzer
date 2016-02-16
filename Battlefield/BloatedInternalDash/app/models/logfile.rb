class Logfile < ActiveRecord::Base
  belongs_to :machine
  belongs_to :service
  belongs_to :server
end
