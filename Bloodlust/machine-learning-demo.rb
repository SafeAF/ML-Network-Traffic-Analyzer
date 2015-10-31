#!/usr/bin/env ruby -w
require 'ruby_fann'
require './liblust'
require './libenum'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'

$logger = Logger.new('bloodlust.log', 'w+')
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




__END__

begin
	logger = Logger.new('bloodlust.log', 'w')
	classifier = Bloodlust.new
	classifier.train_nn
	loopiter = 0
	while true
		loopiter +=1
		p "Looping #{loopiter}"

			blood_output = classifier.run_blood()
			blood_output = blood_output[0]
			logger.info "NEURAL OUTPUT: #{blood_output}"
			# do if ml output suggests a ban
			if blood_output > 0.5
				p "Create ban #{ip}"
			#	ban = Ban.find_by_ip(redi[:src]) || Ban.new

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
