class Student
	#Удобная штука, которая автоматически создает геттеры, сеттеры для всех полей
	attr_accessor :id, :last_name, :first_name, :middle_name, :phone, :telegram, :email, :github

	#Конструктор
	def initialize(id: nil, first_name:, last_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
		@id = id
		@last_name = last_name
		@first_name = first_name
		@middle_name = middle_name
		@phone = phone if Student.phone_number?(phone)
		@telegram = telegram
		@email = email
		@github = github
	end

	def self.phone_number?(phone)
		#Проверяем, что phone - это строка
		return false unless phone.is_a? (String)

		#Проверяем номер длиной 11 символов
		if phone.length == 11
			return phone.match?(/^\d+$/) #Проверка, что все символы - цифры, если номер начинается с 8
		#Проверяем номер длиной 12 символов с кодом страны
		elsif phone.length == 12
			return phone.match?(/^\+\d+$/) #Первый +, останое - цифры
		else
			return false
		end	
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
	phone: "+79528125252",
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

#Тест нового метода phone_number?
puts("+79528125252 - номер? Результат #{Student.phone_number?("+79528125252")}")
puts("89528125252 - номер? Результат #{Student.phone_number?("89528125252")}")
puts("86412346 - номер? Результат #{Student.phone_number?("86412346")}")
puts("+7*******123 - номер? Результат #{Student.phone_number?("+7*******123")}")