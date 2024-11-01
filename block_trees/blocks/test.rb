require_relative '../programs/processing_array'
require 'minitest/autorun'
class TestProcessing_array < Minitest::Test
	
	def test_find_index
		array = [-5,-4,-3,-2,-1,0,1,2,3,4,5]
		proc_array = Processing_array.new(array)
		expected_answer1 = 8
		expected_answer2 = 5
		assert(proc_array.find_index(3) == expected_answer1)
		assert(proc_array.find_index(0) == expected_answer2)
	end

	def test_none
		array = [-5,-4,-3,-2,-1,0,1,2,3,4,5]
		proc_array = Processing_array.new(array)
		expected_answer1 = true
		expected_answer2 = false
		assert(proc_array.none?{|num| num > 5} == expected_answer1)
		assert(proc_array.none?{|num| num < -3} == expected_answer2)
	end
end