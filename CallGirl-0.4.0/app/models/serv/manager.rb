class Manager <  ActiveRecord::Base
	 has_many :servers
	has_many :machines
	has_and_belongs_to_many :admins

end