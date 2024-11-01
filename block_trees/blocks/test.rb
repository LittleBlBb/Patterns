require_relative '../programs/processing_array'
require 'minitest/autorun'

class TestProcessingArray < Minitest::Test
  def test_any
  	array = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
  	array2 = [nil, false]
  	proc_array = ProcessingArray.new(array)
  	proc_array2 = ProcessingArray.new(array2)

  	expected_answer_false = false
  	expected_answer_true = true
  	assert(proc_array.any? == expected_answer_true)
  	assert(proc_array2.any? == expected_answer_false)
  	assert(proc_array.any? {|element| element > 7 } == expected_answer_false)
  	assert(proc_array.any? {|element| element <= 5 }== expected_answer_true)
  end
  def test_find_index
    array = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
    proc_array = ProcessingArray.new(array)
    expected_answer_8 = 8
    expected_answer_5 = 5
    assert(proc_array.find_index(3) == expected_answer_8)
    assert(proc_array.find_index(0) == expected_answer_5)
  end

  def test_none
    array = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
    proc_array = ProcessingArray.new(array)
    expected_answer_true = true
    expected_answer_false = false
    assert(proc_array.none? { |num| num > 5 } == expected_answer_true)
    assert(proc_array.none? { |num| num < -3 } == expected_answer_false)
  end

  def test_reduce
    array = [-5, -4, -3, -2, -1, 1, 2, 3, 4, 5]
    proc_array = ProcessingArray.new(array)
    expected_answer_0 = 0
    expected_answer_negative14400 = -14400
    expected_answer_8 = 8
    assert(proc_array.reduce(0) { |acc, elem| acc + elem } == expected_answer_0)
    assert(proc_array.reduce(1) { |acc, elem| acc * elem } == expected_answer_negative14400)
    assert(proc_array.reduce(8) { |acc, elem| acc + elem } == expected_answer_8)
  end

end
