class Issue  < ActiveRecord::Base
  include Redis::Objects
  belongs_to :issuelist
has_many :labels
  has_many :milestones

end
