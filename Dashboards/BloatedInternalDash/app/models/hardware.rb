class Hardware < ActiveRecord::Base
  belongs_to :user
  belongs_to :machine
  belongs_to :inventory
  belongs_to :operations
end
