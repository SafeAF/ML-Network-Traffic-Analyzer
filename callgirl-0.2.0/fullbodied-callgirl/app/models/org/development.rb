class Development  < ActiveRecord::Base
	has_many :users
  has_many :applications
	belongs_to :infrastructure

end