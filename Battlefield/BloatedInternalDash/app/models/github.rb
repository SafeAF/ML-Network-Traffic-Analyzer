class Github < ActiveRecord::Base
  belongs_to :member
  belongs_to :user
  belongs_to :membership
end
