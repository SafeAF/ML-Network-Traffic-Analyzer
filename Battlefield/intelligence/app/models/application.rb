class Application < ActiveRecord::Base
  belongs_to :process
  belongs_to :node
  belongs_to :machine
  belongs_to :server
  belongs_to :user
  belongs_to :network
  belongs_to :manager
  belongs_to :developer
  belongs_to :pubserver
end
