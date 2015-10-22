#!/usr/bin/env ruby -w
require 'rubygems'
require 'ruby_fann'
require 'drb'
require './liblust'
require './libenum'
require 'drb/acl'
#require 'drb/ssl'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'
require 'active_record'

#$SAFE = 1

### Required for ActiveRecord magick -- Include ALL models
### Don't forget to include app/models/user from kimberlite to
### lend user model and authorize functions
require '../app/models/instance.rb'
require '../app/models/user.rb'
require '../app/models/machine.rb'
# rvm use '1.9.3'


#logger = Logger.new('log/switchyard.log', 'w')

$options = Hash.new
$options[:host] = '10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
#if ARGV[1].include? '--db-config'
	#ActiveRecord::Base.logger = Logger.new('log/db.log')
#	ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
#ActiveRecord::Base.establish_connection('development')
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'emergence',
		:username => 'emergence',
		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
		:host => 'datastore2')

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
	Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})
}

$SHM = Redis::List.new('e:switchyard', :marshall => true)

class Bloodlust
	attr_accessor :bloodlust

 def train_nn
 	dataset_location = '../datasets/training-01.dat' 

	 dataset = []
	 desired_outputs = []
	 raw_dataset = load_training_data(dataset_location)

	 lambda_prepro = Proc.new { |x| normalize_dataset(x, x.mean, x.std) }

  	raw_dataset.each do |dim| 
			data, raw_desired_outputs = format_dataset(dim)
			normalized_data = lambda_prepro.call(data)
			dataset.push(normalized_data)
			desired_outputs.push(raw_desired_outputs)		
	  end

	 training_data = RubyFann::TrainData.new(
		:inputs => dataset,
		:desired_outputs => desired_outputs)

	 @bloodlust = RubyFann::Standard.new(
		:num_inputs => 12,
		:hidden_neurons => [80], # investigate this
		:num_outputs => 1)

	@bloodlust.train_on_data(training_data, 10, 1, 0.01)
	 #@bloodlust.train_on_data(training_data, 10, 1, 0.01)
 end



	def run_blood(input)
		input_ary = input.split(',')
		input_ary.collect! {|i| i.to_f}
		output = @bloodlust.run(input_ary)
	end
end

begin
	logger = Logger.new('bloodlust.log', 'w')
	classifier = Bloodlust.new
	classifier.train_nn
  loopiter = 0
	while true
    loopiter +=1
    p "Looping #{loopiter}"
		redi =  $SHM.shift
		if not redi.empty?
			blood_output = classifier.run_blood(redi[:features_str])
			blood_output = blood_output[0]
			logger.info "NEURAL OUTPUT: #{blood_output}"
      # do if ml output suggests a ban
			if blood_output > 0.5
				ban = Ban.find_by_ip(redi[:src]) || Ban.new
				if ban
					ban.reason = blood_output
					ban.last_seen = redi[:time]
					ban.ip = redi[:src]
				end
			end
		end
		sleep 1
	end

rescue => err
	sleep 0.1
	retry
end

def shut_down
	"Shutdown in progress please wait"
	exit
end

Signal.trap("INT"){
  p "PID #{Process.pid} Caught Sigint"
  shutdown
}

Signal.trap("TERM") {
  raise "PID #{Process.pid} Caught Sigterm"
}


__END__
#	def initialize
#		@nn = RubyFann::Standard.new(:num_inputs => 13,
#				:hidden_neurons => [80], :num_outputs => 1)
#		#@training = RubyFann::TrainData.new(:filename=> 'train.dat')
#	end

#	def train(inputs, desired_outputs)
#		training_data = RubyFann::TrainData.new(
#			:inputs => inputs, :desired_outputs => desired_outputs)
# 		@nn.train_on_data(training_data, 1000, 1, 0.01)
#	end
#
# acl = ACL.new(%w{deny all allow 95.154.200.229 allow 95.154.200.228 allow 98.248.61.31 allow 127.0.0.1})
# DRb.install_acl(acl)
#
# DRb.start_service 'druby://localhost:11000', Bloodlust.new
# puts DRb.uri
# DRb.thread.join

