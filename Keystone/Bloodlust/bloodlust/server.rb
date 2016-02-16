#!/usr/bin/env ruby -w
require 'rubygems'
require 'ruby_fann'
require 'drb'
require './liblust'
require './libenum'
#require 'drb/acl'
#require 'drb/ssl'
require 'rb-inotify'
require 'rubygems'
require 'inline'

class Libem
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_unigrams(VALUE payload) {
				VALUE unigram_hash = rb_hash_new();
				char *data = STR2CSTR(payload);
				int i;
				char unigram[2];
				VALUE count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					snprintf(unigram, sizeof(unigram), "%1c", data[i]);
					if (NIL_P(rb_hash_aref(unigram_hash,
							rb_str_new2(unigram))))
						count = INT2NUM(1);
					else {
						count = rb_hash_aref(unigram_hash,
							rb_str_new2(unigram));
						count = INT2NUM(NUM2INT(count) + 1);
						}
					rb_hash_aset(unigram_hash,
						rb_str_new2(unigram), count);
					}
				return unigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_bigrams(VALUE payload) {
				VALUE bigram_hash = rb_hash_new();
				char bigram[3];
				char *data = STR2CSTR(payload);
				int i, count;
				for (i = 0; i <= strlen(data) - 1; i++) {
					if (i <= (strlen(data) - 2)) {
						snprintf(bigram, sizeof(bigram), "%1c%1c",
								data[i], data[i+1]);
						if (NIL_P(rb_hash_aref(bigram_hash,
								rb_str_new2(bigram))))
							count = INT2NUM(1);
						else {
							count = rb_hash_aref(bigram_hash,
								rb_str_new2(bigram));
							count = INT2NUM(NUM2INT(count) + 1);
							}
						rb_hash_aset(bigram_hash,
							rb_str_new2(bigram), count);
						}
					}
				return bigram_hash;
				}
			}
	end
	inline :C do |builder|
		builder.c %q{
			static VALUE calc_stats(VALUE payload) {
				char *data  = STR2CSTR(payload);
				VALUE stats_hash = rb_hash_new();
				int i, total_chars = 0, count_zero = 0;
				int count_visible = 0;
				int count_nonvisible = 0;
				int count_bigrams = 0;
				double prop_visible = 0;
				double prop_nonvisible = 0;
				double prop_zero = 0;
				for (i = 0; i <= strlen(data) - 1; i++) {

					total_chars++;
					if (data[i] >=32 && data[i] <= 128)
						count_visible++;
					else if (data[i] < 32 || data[i] > 128)
						count_nonvisible++;
					if (data[i] == 48) count_zero++;
					}
				prop_visible = (double) count_visible / total_chars;
				prop_nonvisible = (double) count_nonvisible /
					total_chars;
				prop_zero = (double) count_zero / total_chars;
				rb_hash_aset(stats_hash, rb_str_new2("total_chars"),
					INT2NUM(total_chars));
				rb_hash_aset(stats_hash, rb_str_new2("count_visible"),
					INT2NUM(count_visible));
				rb_hash_aset(stats_hash, rb_str_new2("count_nonvisible"),
					INT2NUM(count_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("count_zero"),
					INT2NUM(count_zero));
				rb_hash_aset(stats_hash, rb_str_new2("prop_visible"),
					rb_float_new(prop_visible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_nonvisible"),
					rb_float_new(prop_nonvisible));
				rb_hash_aset(stats_hash, rb_str_new2("prop_zero"),
					rb_float_new(prop_zero));
				return stats_hash;
				}
			}
	end

	def prepare_features(payload)
		features = ""
		ug = []
		bg = []
		stat = []
		ugs = self.calc_unigrams(payload)
		bgs = self.calc_bigrams(payload)
		stats = self.calc_stats(payload)
		stats["count_unigrams"] = ugs.keys.count
		stats["count_bigrams"] = bgs.keys.count
		stats["mf_unigram"] = ugs.max_by {|key, value| value}
		stats["prop_mf_unigram"] = ugs.values.max.quo(stats["count_unigrams"]).to_f
		stats["mf_bigram"] = bgs.max_by {|key, value| value}
		stats["prop_mf_bigram"] = bgs.values.max.quo(stats["count_bigrams"]).to_f

		stats.sort.each {|key,value|
			features += value.to_s + ','
		}
		features.chomp! ","
		features
	end
end



$SAFE = 1

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
	# set to 10 for development, set to 1000 for production
	@bloodlust.train_on_data(training_data, 10, 1, 0.01)
	 #@bloodlust.train_on_data(training_data, 10, 1, 0.01)
 end

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

	def run_blood(input)
		input_ary = input.split(',')
		input_ary.collect! {|i| i.to_f}
		output = @bloodlust.run(input_ary)
	end
	

end

def monitor_logfile(filename)
	begin
		open(filename) do |file|
			file.read
			queue = INotify::Notifier.new
			queue.watch(filename, :modify) do
				yield file.read
			end
			queue.run
		end

	rescue => err
	#	$logger.error "[#{Time.now}]: Error #{err}"
	ensure

	end
end

$blood = Bloodlust.new
$blood.train_nn
monitor_logfile '/var/log/apache2/access.log' do |data|
#monitor_logfile '/home/vishnu/source/Alpha/Battlefield/bloodlust/foo.txt' do |data|
 # pre = Libem.new
#features = pre.prepare_features(data)
  p data
  if data =~ /127.0.0.1/
p "Attack detected"
  else
    p "No attack detected"
  end

#$blood.run_blood(features)

end

#acl = ACL.new(%w{deny all allow 95.154.200.229 allow 95.154.200.228 allow 98.248.61.31 allow 127.0.0.1})
#DRb.install_acl(acl)
#
# DRb.start_service 'druby://localhost:11000', Bloodlust.new
# puts DRb.uri
# DRb.thread.join
