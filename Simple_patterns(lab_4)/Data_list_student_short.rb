require_relative 'Data_list'
require_relative 'Data_table'
class Data_list_student_short < Data_list

	def initialize(student_short_array)
		super(student_short_array)
	end

	def get_names
		["№", "ФИО", "Гит", "Контакты"]
	end

	def get_data
		index = 1
		result = [self.get_names]
		selected = self.get_selected
		selected.each do |sel_ind|
			obj = self.data[sel_ind]
			row = [index, obj.initials, obj.github, obj.contact]
			result << row
			index += 1
		end
		Data_table.new(result)
	end
end
