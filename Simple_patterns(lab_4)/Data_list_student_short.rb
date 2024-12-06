require_relative 'Data_list'
require_relative 'Data_table'
class Data_list_student_short < Data_list
	
	def initialize(student_short_array)
		super(student_short_array)
	end

	def get_names
		fields = self.array
			.first[:data]
			.instance_variables
		fields.delete(:@id)
		fields
	end

	def get_data(attributes)
		matrix = []
		self.array.each_with_index do |elem, index|
			student_short = elem[:data]
			row = [index+1]
			attributes.each_with_index do |attribute|
				row << student_short.instance_variable_get(attribute)
			end
			matrix << row
		end
		return Data_table.new(matrix)
	end

	def to_s
		self.array.inspect
	end
end
class StudentShort
	include Comparable
	attr_accessor :id, :surname, :age
	def initialize(id, surname, age)
		@id = id
		@surname = surname
		@age = age
	end

	def <=>(other)
		if self.age < other.age
			return -1
		elsif self.age > other.age
			return 1
		else
			return 0
		end
	end
end