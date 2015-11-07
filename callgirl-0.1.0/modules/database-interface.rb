#!/usr/bin/env ruby


#ActiveRecord::Base.logger = Logger.new('log/db.log')

#	ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
#ActiveRecord::Base.establish_connection('development')
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'callgirl',
		:username => 'callgirl',
		:password => 'githerdunno',
		:host => 'datastore2',
		:url => "mysql2://callgirl:githerdunno@10.0.1.32/callgirl")