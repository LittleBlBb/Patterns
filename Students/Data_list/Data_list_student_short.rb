require_relative 'Data_list'
require_relative 'Data_table'
class Data_list_student_short < Data_list

	private

	def column_names
		["№", "ФИО", "Гит", "Контакт"]
	end

	def build_row(index, obj)
		[index, obj.initials, obj.github, obj.contact]
	end
end
