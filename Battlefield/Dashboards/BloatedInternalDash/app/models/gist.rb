class Gist < ActiveRecord::Base
  belongs_to :user
  belongs_to :member
  belongs_to :github
  belongs_to :git
  belongs_to :project
end
