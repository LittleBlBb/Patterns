class Data_list

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
		self.selected.dup
	end

	def get_names
		@column_names
	end

	protected

	def get_data
		raise NotImplementedError, "Method not implemented"
	end

  private

  attr_accessor :selected

  def data=(data)
		@data = data
	end

  def data
		@data.clone
	end
end