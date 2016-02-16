class Infrastructure < ActiveRecord::Base
  belongs_to :cluster
  belongs_to :user
  belongs_to :admin
  belongs_to :operations
end
