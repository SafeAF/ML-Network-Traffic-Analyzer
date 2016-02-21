class Todo < ActiveRecord::Base
  belongs_to :tasklist
  belongs_to :user
end
