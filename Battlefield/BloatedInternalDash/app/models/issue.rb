class Issue < ActiveRecord::Base
  belongs_to :user
  belongs_to :label
  belongs_to :project
  belongs_to :issuelist
end
