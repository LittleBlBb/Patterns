class Data_table
	def initialize(data)
		self.data = data
	end

	def get_element(row, col)
		self.data[row][col]
	end

	def row_count
		self.data.size
	end

  def col_count
		if self.data.empty?
			return 0
		end
		self.data[0].size
	end

  def to_s
		self.data.inspect
	end

  private

	def data
		@data.clone
	end

  def data=(data)
		unless data.is_a?(Array) && data.all? {|row| row.is_a?(Array)}
			raise ArgumentError, "data should be a matrix"
		end
		@data = data
	end
end


