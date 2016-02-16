#!/usr/bin/env ruby -w
require 'rubygems'
require 'ruby_fann'
require 'redis'
require 'redis-objects'
require 'connection_pool'
require 'logger'

#require File.expand_path(File.dirname(__FILE__) + '/liblust')
require File.expand_path(File.dirname(__FILE__) + '/libenum')

$options = Hash.new
$options[:host] = '10.0.1.75' #'10.0.1.17'
$options[:port] = '6379'
$options[:table] = 5

Redis::Objects.redis = ConnectionPool.new(size: 5, timeout: 5) {
  Redis.new({host: $options[:host], port: $options[:port], db: $options[:table]})}

$SWY = Redis::List.new('e:switchyard', :marshall => true)
$BANS = Redis::List.new('attrition:bans', :marshall => true)


class Bloodlust
  attr_accessor :ml, :dataset, :desiredOutputs, :rawDataset, :trainsetLocation
  attr_accessor :train

  def initialize(trainsetLocation = '../datasets/training-01.dat' )
    @dataset = []
    @desiredOutputs = []
    @rawDataset = []
    @trainsetLocation = trainsetLocation
  end

  # Goes through each item in an array and normalizes it by taking the
  # arctan of the value minus the mean over the standard deviation
  def normalize_dataset(raw_data, mean, std)
    raw_data.map! { |entry| Math.atan(((entry - mean)).abs / std) }
  end


  def format_dataset(input_data) # chop off the numerical data elements 9-13
    @tmpDataset = input_data.slice(9,12)
    @desiredOutputs.push input_data.pop.to_i
    @tmpDataset.map! {|x| x.to_f}
    return @tmpDataset
  end

  def open_training_dataset(datasetLocation)
    @raw_data = []
    File.open(datasetLocation) do |f|
      f.each_line do |line|
        line.chomp!
        ary = line.split(',')
        @raw_data.push(ary)
      end
    end
    @raw_data
  end

  def process_trainset(raw_dataset)
    lambda_prepro = Proc.new { |x| normalize_dataset(x, x.mean, x.std) }

    raw_dataset.each do |dim|
      data = format_dataset(dim)
      normalized_data = lambda_prepro.call(data);
      @dataset.push(normalized_data)
    ## do i need to push desiredoutputs into an array of arrays or is it already -> take the time to look
     # @desiredOutputs.push(raw_desired_outputs)
    end
  end

  def produce_training_set()
    process_trainset(open_training_dataset(@trainsetLocation))
  end

  def trainNN()
    @train = RubyFann::TrainData.new(
          :inputs => @dataset,
          :desired_output => @desiredOutput)
  end

  def loadNN(stored_training_data = 'bloodlust.train')
    @train.clear if !@train.nil?
    @train = RubyFann::TrainData.new(filename: stored_training_data)
    @ml = RubyFann::Standard.new(
        :num_inputs => 13,
        :hidden_neurons => [80], # investigate this
        :num_outputs => 1)
    @ml.train_on_data(@train, 10, 1, 0.01)
  end

  def buildNN()
    @ml = RubyFann::Standard.new(
      :num_inputs => 13,
      :hidden_neurons => [80], # investigate this
      :num_outputs => 1)

    @ml.train_on_data(@train, 10, 1, 0.01)
  end


end

begin
  classifier = Bloodlust.new
#  classifier.produce_training_set();   p 'foo'
  #classifier.trainNN()
  classifier.loadNN()
 # classifier.buildNN()

  while true
    loopiter +=1
    p "foo"
    p "Looping #{loopiter.to_s}"
    redi =  $SHM.shift
    if not redi.empty?
      blood_output = classifier.run(redi[:features_str])
      blood_output = blood_output[0]
      logger.info "NEURAL OUTPUT: #{blood_output}"
      # do if ml output suggests a ban
      if blood_output > 0.5
        redi[:ban_output] = blood_output
        $BANS.push redi
      end
      #ban = Ban.find_by_ip(redi[:src]) || Ban.new
      #if ban
      #	ban.reason = blood_output
      #	ban.last_seen = redi[:time]
      #	ban.ip = redi[:src]
      #end
      #end
    end
    sleep 1
  end

  rescue => err
    sleep 1.0
    retry
end



__END__
class Bloodlust
  attr_accessor :ml, :dataset, :desiredOutputs, :rawDataset

  def initialize
    @dataset = []
    @desiredOutputs = []
    @rawDataset = []
  end

  def open_training_dataset(datasetLocation)
  File.open(datasetLocation) do |f|
    f.each_line do |line|
      line.chomp!
      ary = line.split(',')
      raw_data.push(ary)
    end
  end

  end

  ## Cast dataset as float/int
  def format_dataset(input_data) # chop off the numerical data elements 9-13
    dataset = []
    desired_output = []

    dataset = input_data.slice(9,12)

    raw_desired_output = input_data.pop
    dataset.map! {|x| x.to_f}

    desired_output.push raw_desired_output.to_i
    return dataset, desired_output
  end

  def normalize_data()
  lambda_prepro = Proc.new { |x| normalize_dataset(x, x.mean, x.std) }

  raw_dataset.each do |dim|
    data, raw_desired_outputs = format_dataset(dim)
    normalized_data = lambda_prepro.call(data)
    dataset.push(normalized_data)
    desired_outputs.push(raw_desired_outputs)
  end
  end



end

b = Bloodlust.new
