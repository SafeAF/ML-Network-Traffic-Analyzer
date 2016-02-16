class Issuelist < ActiveRecord::Base
  belongs_to :project
  belongs_to :department
end
