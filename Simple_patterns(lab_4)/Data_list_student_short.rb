require_relative 'Data_list'
require_relative 'Data_table'
class Data_list_student_short < Data_list

	def initialize(elems)
		super(elems, ["№", "ФИО", "Гит", "Контакт"])
	end

	private

	def build_row(index, obj)
		[index, obj.initials, obj.github, obj.contact]
	end
end
