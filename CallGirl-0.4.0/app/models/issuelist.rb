class Issuelist < ActiveRecord::Base
  belongs_to :project
  has_many :issues
  has_many :labels

end