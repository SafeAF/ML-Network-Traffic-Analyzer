class Cluster  < ActiveRecord::Base
	belongs_to :user
	has_many :machines

end