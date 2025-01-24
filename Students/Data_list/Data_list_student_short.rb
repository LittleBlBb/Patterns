require_relative 'Data_list'
require_relative 'Data_table'
class Data_list_student_short < Data_list
	attr_accessor :count
	def initialize(elem)
		super(elem)
		@observers = []
	end

	def add_observer(obs)
		@observers << obs
	end

	def remove_observer(obs)
		@observers.delete(obs)
	end

	def notify
		@observers.each do |obs|
			obs.set_table_params(column_names, @count)
			obs.set_table_data(get_data)
		end
	end

	private

	def column_names
		["№", "ФИО", "Гит", "Контакт"]
	end

	def build_row(obj)
		[obj.id, obj.initials, obj.github, obj.contact]
	end
end
