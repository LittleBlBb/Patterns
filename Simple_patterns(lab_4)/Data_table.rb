class Data_table

	attr_accessor :matrix
	private :matrix, :matrix=

	def initialize(matrix)
		self.matrix = matrix
	end

	def [](row, column)
		if row < 0 || row >= row_count 
			raise IndexError.new('Invalid row index')
		elsif column < 0 || row >= column_count
			raise IndexError.new('Invalid column index')
		end

		self.matrix[row][column]
	end

	def row_count
		self.matrix.size
	end

	def column_count
		self.matrix.max { |a, b| a.size <=> b.size }.size 
	end

	def to_s
		matrix.map {|row| row.join(",")}.join("\n")
	end
end