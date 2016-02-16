class NetworkBox < ActiveRecord::Base
  belongs_to :network
  belongs_to :infrastructure
  belongs_to :operations
end
