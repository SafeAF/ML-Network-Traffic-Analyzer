class Audittrail < ActiveRecord::Base
	include Redis::Objects
	include Mongoid::Document
	 belongs_to :user
	belongs_to :machine

end