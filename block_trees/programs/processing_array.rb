class Processing_array
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
		if index >= array.size
			raise IndexError
		else
		self.array(index)
		end
	end

	def <=>(other)
	    if self.array.sum < other.array.sum
	      return -1
	    elsif self.array.sum == other.array.sum
	      return 0
	    else
	      return 1
	    end
	end

    def find_index(value)
    	self.array.each_with_index do |item, index|
    		if item == value
    			return index
    		end
   	    end
   	    nil
   	end
end