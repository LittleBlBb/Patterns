require_relative '../programs/processing_array'
require 'minitest/autorun'

class TestProcessing_array < Minitest::Test
	def test_find_index

		proc_array = Processing_array.new([-5,-4,-3,-2,-1,0,1,2,3,4,5])
		expected_answer1 = 8
		expected_answer2 = 5
		assert(proc_array.find_index(3) == expected_answer1)
		assert(proc_array.find_index(0) == expected_answer2)
	end
end