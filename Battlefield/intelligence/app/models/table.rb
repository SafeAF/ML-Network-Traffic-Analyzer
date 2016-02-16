class Table < ActiveRecord::Base
  belongs_to :application
  belongs_to :database
end
