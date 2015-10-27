class Privkey < ActiveRecord::Base
	belongs_to :user

belongs_to :machine
belongs_to :server

end
