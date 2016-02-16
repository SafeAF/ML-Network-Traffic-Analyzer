class Group < ActiveRecord::Base
  belongs_to :vfilesystem
  belongs_to :machine
  belongs_to :server
end
