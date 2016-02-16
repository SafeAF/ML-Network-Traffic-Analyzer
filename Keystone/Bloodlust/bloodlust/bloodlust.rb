#!/usr/bin/env ruby -w
require 'rubygems'
require 'ruby_fann/neural_network'
require 'liblust'
require 'libenum'
# gem install ruby-fann
$VERSION = '0.1.1'
#puts'********************************************************************'
#puts'*************************** [BLOODLUST] ****************************'
#puts'********************************************************************'
#puts"* BMN Machine Learning Anomaly IDS -- Ruby Implementation v#{$VERSION}" +
#    "     *"
#puts'* Copyright (C) 2011 BareMetal Networks Corporation                *'
#puts'********************************************************************'
#puts'* RESTRICTED -- EYES ONLY -- CORPORATE TRADE SECRETS               *' 
#puts'* DISCLOSURE OF ANY MATERIAL HEREIN IS ILLEGAL                     *'
#puts'* VIOLATORS WILL BE PUNISHED TO THE FULL EXTENT OF THE LAW         *'
#puts'********************************************************************'
#puts'********************************************************************'

## MAIN ##

def run_train_bloodlust
#dataset_location = 'train.dat'
dataset_location = '../datasets/training-01.dat' 
# dataset_location = 'sample_dataset.dat'
  #p "[DATASET] - Loading #{dataset_location}..."
 
# ORDER OF DATASET
#    [:uni_entropy, :bi_entropy, :prop_mf_unigram,
#	 :prop_mf_bigram, :num_print, :num_no_print, 
#	 :prop_print, :prop_no_print, :num_zeros,
#	 :prop_zeros, :num_mf_unigram, :num_mf_bigram]
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

 #bloodlust = train_bloodlust(dataset, desired_outputs)
end

bloodlust = run_train_bloodlust
#bloodlust.save('bloodlust.nn')

#bloodlust = RubyFann::Standard.new(:filename => 'bloodlust.nn')

#def run_bloodlust(bloodlust, input)
#outputs = bloodlust.run(input)
#end



