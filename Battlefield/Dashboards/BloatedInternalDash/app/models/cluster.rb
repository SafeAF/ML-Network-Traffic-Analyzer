class Cluster < ActiveRecord::Base
  belongs_to :user
  belongs_to :infrastructure
  belongs_to :organization
end
