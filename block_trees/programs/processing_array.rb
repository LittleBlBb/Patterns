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

  def <=>(other)
    if self.array.sum < other.array.sum
      -1
    elsif self.array.sum == other.array.sum
      0
    else
      1
    end
  end

  def find_index(value)
    self.array.each_with_index do |item, index|
      return index if item == value
    end
    nil
  end

  def none?
    return true if !block_given? && array.empty?

    self.array.each do |element|
      return false if yield(element)
    end
    true
  end

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
