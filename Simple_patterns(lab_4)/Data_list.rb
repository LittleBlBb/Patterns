class Data_list

	attr_reader :array
	private :array

	def initialize(array)
		self.array = array
	end

	def array=(array)
		if array.is_a?(Array)
			sorted_array = []
			array.sort{|a, b| b <=> a}.each do |elem|
				sorted_array << {data: elem, selected: false}
			end
			@array = sorted_array
		else
			raise ArgumentError, "Expected Array, Given #{array.class.name}"
		end
	end

	def select(number)
		if number <= 0 || number > self.array.size
			raise IndexError,'Invalid index'
		end
		self.array[number-1][:selected] = true
	end

	def get_selected
		self.array.find_all{|elem| elem[:selected] == true}		
	end

	protected
	
	def get_names
		raise NotImplementedError, 'This method must be implemented in a subclass'
	end

	def get_data
		raise NotImplementedError, 'This method must be implemented in a subclass'	
	end
end

