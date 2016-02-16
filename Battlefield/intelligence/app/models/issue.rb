class Issue < ActiveRecord::Base
  belongs_to :project
  belongs_to :department
  belongs_to :infrastructure
  belongs_to :operations
  belongs_to :username
  belongs_to :user
  belongs_to :label
end
