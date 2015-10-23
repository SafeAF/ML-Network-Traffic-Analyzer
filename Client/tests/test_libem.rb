require 'test/unit'
require 'libem'

class TestLibem < Test::Unit::TestCase
	def test_calc_unigrams
		libem = Libem.new
		test_string = "\tThis is a test string!!\n0"
		expected_unigrams = {"\t"=>1, "T"=>1, "h"=>1, "i"=>3, 
						"s"=>4, " "=>4, "a"=>1, "t"=>3, "e"=>1, 
						"r"=>1, "n"=>1, "g"=>1, "!"=>2, "\n"=>1, "0"=>1}
		unigrams = Hash.new
		unigrams = libem.calc_unigrams test_string
		assert_equal expected_unigrams, unigrams
	end

	def test_calc_bigrams
		libem = Libem.new
		test_string = "\tThis is a test string!!\n0"
		expected_bigrams = {"\tT"=>1, "Th"=>1, "hi"=>1, "is"=>2, "s "=>2, 
						" i"=>1, " a"=>1, "a "=>1, " t"=>1, "te"=>1,
						"es"=>1, "st"=>2, "t "=>1, " s"=>1, "tr"=>1,
						"ri"=>1, "in"=>1, "ng"=>1, "g!"=>1, "!!"=>1,
						"!\n"=>1, "\n0"=>1}
		bigrams = Hash.new
		bigrams = libem.calc_bigrams test_string
		assert_equal expected_bigrams, bigrams
	end

	def test_calc_stats
		libem = Libem.new
		test_string = "\tThis is a test string!!\n0"
		expected_stats = {"total_chars"=>26, "count_visible"=>24,
						"count_nonvisible"=>2, "count_zero"=>1, 
						"prop_visible"=>(24.0 / 26.0), 
						"prop_nonvisible"=>(2.0 / 26.0), 
						"prop_zero"=>(1.0 / 26.0)}
		stats = Hash.new
		stats = libem.calc_stats test_string
		assert_equal expected_stats, stats
	end

	def test_prepare_features
		libem = Libem.new
		test_string = "\tThis is a test string!!\n"
		# Sorted order: 
		# count_bigrams, count_nonvisible, count_unigrams, count_visible,
		# count_zero, mf_bigram, mf_unigram,
		# prop_mf_bigram, prop_nonvisible, prop_mf_unigram, prop_visible,
		# prop_zero, total_chars
		expected_features = "21,2,14,23,0,st2, 4," +(2.0 / 21.0).to_s +
							"," + (4.0 / 14.0).to_s + "," + 
							 (2.0 / 25.0).to_s + "," + (23.0 / 25.0).to_s +
							"," + (0.0 / 25.0).to_s + ",25"
		features = ""
		features = libem.prepare_features test_string
		assert_equal expected_features, features
	end
end
