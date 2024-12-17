class Data_list

  def initialize(elem, column_names)
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
		self.selected.dup
	end

	def get_names
		@column_names
	end

	def get_data
		result = [self.get_names]
		index = 1
		selected.each do |elem|
			obj = self.data[elem]
			row = build_row(index, obj)
			result << row
			index += 1
		end
	end

	private

	def build_row(index, element)
		raise NotImplementedError, "Метод не реализован в классе Data_list"
	end

  protected

  attr_accessor :selected

  def data=(data)
		@data = data
	end

  def data
		@data.clone
	end
end