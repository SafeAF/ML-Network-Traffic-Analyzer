require 'test/unit'
require 'liblust'

class TestLibLust < Test::Unit::TestCase

# def TestFormatForNeural

#	format_for_neural()
# end
	TESTDATA = [5.00812198810159,3.59034623881499,
				0.0719424460431655,0.0215827338129496,
				6.30267541295261,4.22384341344069,
				0.066079295154185,0.0220264317180617]



	def test_normalize_dataset
	expected = [0.7759, 0.4188, -0.7247, -0.7353, 0.9737,
				 0.6003, -0.7259, -0.7352]
	end


end




