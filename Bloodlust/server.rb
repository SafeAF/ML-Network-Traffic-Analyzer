#!/usr/bin/env ruby -w
require 'rubygems'
require 'ruby_fann'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'
require 'active_record'

BASE_PATH = File.expand_path File.join(File.dirname(__FILE__), '..')
$:.unshift File.join(BASE_PATH, 'lib')

ROOT = File.join(File.dirname(__FILE__), '..')
# load in directories with modules and lbis etc
['../Lib/models/*' '../lib', '../db', 'lib/*'].each do |folder|
	$:.unshift File.join(ROOT, folder)
end


#  Add methods to Enumerable, available in Array
module Enumerable

	def sum
		return self.inject(0){|acc,i|acc +i}
	end

	def mean
		return self.sum/self.length.to_f
	end

	def variance
		avg=self.mean
		sum=self.inject(0){|acc,i| acc + (i-avg)**2}
		return sum/(self.length - 1).to_f
	end

	def std
		return Math.sqrt(self.variance)
	end

end  #  module Enumerable
## Liblust.rb ##

# Goes through each item in an array and normalizes it by taking the
# arctan of the value minus the mean over the standard deviation
def normalize_dataset(raw_data, mean, std)
	raw_data.map! { |entry| Math.atan(((entry - mean)).abs / std) }
end

# returns an array of arrays
def load_training_data(filename)
	raw_data = []
	file = File.open(filename)
	while(line = file.gets) do
		line.chomp!
		ary = line.split(',')
		raw_data.push(ary)
	end
	return raw_data
end

def format_dataset(input_data)
	dataset = []
	desired_output = []
#p input_data
# chop off the numerical data elements 9-13
#TODO  check to make sure this is right!
	dataset = input_data.slice(9,12)

	raw_desired_output = input_data.pop
	dataset.map! {|x| x.to_f}

	desired_output.push raw_desired_output.to_i
	return dataset, desired_output
end

#make configurable
def train_bloodlust(inputs, desired_outputs)
	p "[NEURAL] - Training now"
	training_data = RubyFann::TrainData.new(
			:inputs => inputs,
			:desired_outputs => desired_outputs)

	p "[NEURAL] - Training complete"

	bloodlust = RubyFann::Standard.new(
			:num_inputs => 13,
			:hidden_neurons => [80], # investigate this
			:num_outputs => 1)

	bloodlust.train_on_data(training_data, 1000, 1, 0.01)
	return bloodlust
end

## Produces an array of arrays composed of floats
def format_for_neural(formattee)
	formatted = []
	formattee.each  do |entry|
		temp = []
		entry.each { |y| temp.push y.to_f }
		formatted.push(temp)
	end
	formatted
end

$FAILURES = 0
$FAILURES_CLOCK_START = Time.now
$FAILURES_CLOCK_END = Time.now
$FAILURE_RATE = 0.0
	def calc_failure_rate
	timed = $FAILURES_CLOCK_START - $FAILURES_CLOCK_END
	integerSeconds = timed.to_f
	$FAILURE_RATE = $FAILURES / integerSeconds
	end

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
$options[:host] = 'localhost' #'10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5
#if ARGV[1].include? '--db-config'
	#ActiveRecord::Base.logger = Logger.new('log/db.log')
#	ActiveRecord::Base.configurations = YAML::load(IO.read('../config/database.yml'))
#end
#ActiveRecord::Base.establish_connection('development')
begin
ActiveRecord::Base.establish_connection(
		:adapter => 'mysql2',
		:database => 'emergence',
		:username => 'emergence',
		:password => '#GDU3im=86jDFAipJ(f7*rTKuc',
		:host => 'datastore2',
		:timeout => 1000,
		:pool => 5)
rescue => err
	ActiveRecord::Base.establish_connection(
			:adapter => 'sqlite3',
			:database => 'emergence.db',
			:timeout => 1000,
    	:pool => 5)
end




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
	sleep 1.0
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

