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


def format_for_neural(formattee)
 formatted = []
  formattee.each  do |entry|
   	temp = []
 	entry.each { |y| temp.push y.to_f }
	 formatted.push(temp)
  end
 formatted
end




