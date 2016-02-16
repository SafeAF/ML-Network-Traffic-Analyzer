class Network < ActiveRecord::Base
  belongs_to :infrastructure
  belongs_to :user
  belongs_to :cluster
  belongs_to :operations
end
