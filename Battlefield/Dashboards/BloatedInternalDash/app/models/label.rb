class Label < ActiveRecord::Base
  belongs_to :issue
  belongs_to :milestone
end
