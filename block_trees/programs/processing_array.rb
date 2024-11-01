class ProcessingArray
  attr_reader :array

  def initialize(array)
    self.array = array
  end

  def array=(array)
    raise TypeError.new("Given #{array.class.name}, Expected Array") unless array.is_a?(Array)
    @array = array
  end

  private :array=

  def [](index)
    raise IndexError if index >= array.size || index < 0
    array[index]
  end
#1
  def any?
  	if !block_given?
  		self.array.each do |element|
  			return true unless element.nil? || element == false
  		end
  		return false
  	end
  	self.array.each do |element|
  		return true if yield(element)
  	end
  	false
  end
  #12
  def find_all
  	result = []
  	self.array.each do |element|
  		result << element if yield(element)
  	end
  	result
  end
  #13
  def find_index(value)
    self.array.each_with_index do |item, index|
      return index if item == value
    end
    nil
  end
  #25
  def none?
    return true if !block_given? && array.empty?

    self.array.each do |element|
      return false if yield(element)
    end
    true
  end
  #36
  def reduce(initial_value = nil)
    if initial_value.nil?
      accumulator = array[0]
      start_index = 1
    else
      accumulator = initial_value
      start_index = 0
    end

    for i in start_index...array.size
      element = array[i]
      accumulator = yield(accumulator, element)
    end
    accumulator
  end
end
