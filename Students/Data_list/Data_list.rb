class Data_list
	attr_accessor :selected
  def initialize(elem)
		@column_names = column_names
		self.data = elem
		@selected=[]
	end

  def select(num)
		element = self.data[num]
		if element && !self.selected.include?(element.id)
			self.selected << num
		end
	end

  def get_selected
		self.selected.clone
	end

	def get_names
		@column_names
	end

	def get_data
		result = [self.get_names]
		self.selected.each do |elem|
			obj = self.data[elem]
			row = build_row(obj)
			result << row
		end
		Data_table.new(result)
	end

	def data=(data)
		@data = data
	end

	def data
		@data.clone
	end

	private

  def column_names
		raise NotImplementedError, "Method 'column_names' not implemented"
	end

	def build_row(element)
		raise NotImplementedError, "Method 'build_row' not implemented"
	end
end