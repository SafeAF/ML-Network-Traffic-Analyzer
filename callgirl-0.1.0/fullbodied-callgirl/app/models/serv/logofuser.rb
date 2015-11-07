class Logofuser < ActiveRecord::Base
	belongs_to :machine
	has_many :audittrails

end