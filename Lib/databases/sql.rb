
Redis::Objects.redis = ConnectionPool.new(size: 10, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('application:general', :marshal => true)



ActiveRecord::Base.$logger = Logger.new('log/db.log')
ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))

ActiveRecord::Base.logger = Logger.new('db.log')
# if Rails.env (is this the correct premise?) is development then
#  establish connection development else do the default jingle here
#ActiveRecord::Base.establish_connection(:development)
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'emergence',
		:username => 'emergence',
		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
		:host => 'datastore2')

class User < ActiveRecord::Base
	establish_connection()


end

class File
	include Redis::Objects
end

class Group
	include Mongoid::Document
end
