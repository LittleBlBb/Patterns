class Student
	#Удобная штука, которая автоматически создает геттеры, сеттеры для всех полей
	attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :github

	#Конструктор
	def initialize(id: nil;, first_name:, last_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
		@id = id
		@last_name = last_name
		@first_name = first_name
		@middle_name = middle_name
		@phone = phone
		@telegram = telegram
		@email = email
		@github = github
	end

	#Метод для вывода информации о студенте
	def display_info
		puts("ID: #{@id}") if @id
		puts("Фамилия: #{@last_name}")
		puts("Имя: #{@first_name}")
		puts("Отчество: #{@middle_name}")
		puts("Телефон: #{@phone}") if @phone
		puts("Телеграм: #{@telegram}") if @telegram
		puts("Почта: #{@email}") if @email
		puts("Github: #{@github}") if @github
	end
end

#Создание экземпляра класса Student
student = Student.new(
	first_name: "Андрей",
	last_name: "Пшеничнов",
	middle_name: "Александрович",
	id: 1,
	phone: "+7952812525",
	telegram: "@test_telegram",
	email: "apdragon2014@gmail.com",
	github: "https://github.com/LittleBlBb"
)
student.display_info

#Пример использования сеттера и геттера
student.id= 52
puts("\nID = #{student.id}")
student.telegram= "changed_tg"
puts("telegram: #{student.telegram}")

student.display_info