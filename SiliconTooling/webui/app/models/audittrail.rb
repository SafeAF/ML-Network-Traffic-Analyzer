class Audittrail < ActiveRecord::Base
	 belongs_to :user
	belongs_to :machine

end