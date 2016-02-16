class System < ActiveRecord::Base
  belongs_to :cluster
  belongs_to :infrastructure
end
