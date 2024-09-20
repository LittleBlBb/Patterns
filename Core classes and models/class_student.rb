class Student
	#Удобная штука, которая автоматически создает геттеры, сеттеры для всех полей
	attr_accessor :id
	#Автоматом делает геттеры
	attr_reader :phone, :telegram, :email, :github, :last_name, :first_name, :middle_name
	#Конструктор
	def initialize(id: nil, first_name:, last_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
		@id = id
		@last_name = last_name
		@first_name = first_name
		@middle_name = middle_name
		self.phone = phone if phone #Валидация в сеттере
		self.telegram = telegram if telegram #Валидация в сеттере
		self.email = email if email #Валидация в сеттере
		self.github = github if github #Валидация в сеттере
	end

	#Строковое представление объекта
	def to_s
		str = []
		str << "ID: #{@id}" if @id
		str << "Имя: #{@first_name}"
		str << "Фамилия: #{@last_name}"
		str << "Отчество: #{@middle_name}"
		str << "Телефон: #{@phone}" if phone
		str << "Телеграм: #{@telegram}" if telegram
		str << "Почта: #{@email}" if email
		str << "GitHub: #{@github}" if github
		str.join(';')
	end

	def get_info
		info = []
		info << "Инициалы: #{@last_name} #{@first_name[0]}.#{@middle_name[0]}."
		info << "GitHub: #{@github}" if github
		if phone
			info << "Телефон: #{@phone}"
		elsif email
			info << "Почта: #{@email}"
		elsif telegram
			info << "Телеграм: #{@telegram}"
		end
		info.join(';')
	end

	def self.from_string(str)
		#Создаем пустой хэш
		data = {}

		#Парсим строку по "; " и извлекаем ключи и значения
		str.split('; ').each do |pair|
			key, value = pair.split(': ').map(&:strip)
			#Заполняем хэш
			case key
			when "ID"
				data[:id] = value.to_i
			when "Имя"
				data[:first_name] = value
			when "Фамилия"
				data[:last_name] = value
			when "Отчество"
				data[:middle_name] = value
			when "Телефон"
				data[:phone] = value
			when "Телеграм"
				data[:telegram] = value
			when "Почта"
				data[:email] = value
			when "GitHub"
				data[:github] = value
			end
		end

		#Передаем хэш с параметрами в конструктор(** отвечает за развертывание хэша, превращая его ключи в аргументы конструктора)
		self.new(**data)
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
		puts("GitHub: #{@github}") if @github
	end

	#Валидация номера телефона
	def self.phone_valid?(phone)
		#Проверяем, что phone - это строка
		return false unless phone.is_a?(String)

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

	#Сеттер гита с валидацией
	def github=(github)
		if Student.github_valid?(github)
			@github = github
		else
			puts "Invalid GitHub"
		end
	end

	#Валидация почты
	def self.email_valid?(email)
		email.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
	end

	#Валидация телеги
	def self.telegram_valid?(telegram)
		telegram.match?(/\A@[a-zA-Z0-9_]{5,}\z/)
	end

	#Валидация гитхаба
	def self.github_valid?(github)
		github.match?(/\Ahttps:\/\/github.com\/[a-zA-Z0-9_-]+\z/)
	end

	#Проверяем, присутствует ли хотя бы один контакт студента
	def contact_present?
		@phone || @phone || @email
	end

	#Проверяем, присутствует ли гит у студента
	def git_present?
		@github
	end

	#Метод, проводящий две валидации: наличие гита и наличие любого контакта для связи
	def validate
		errors = []
		errors << "GitHub не указан в профиле студента" unless git_present?
		errors << "Контакты не указаны в профиле студента" unless contact_present?
		
		if errors.empty?
			puts "Валидация пройдена"
		else
			puts "Валидация не пройдена\nОшибки валидации:"
			errors.each{|error| puts error}
		end
	end

	#Метод для установки значений контактов
	def set_contacts(phone: nil, email: nil, telegram: nil)
		self.phone = phone
		self.email = email
		self.telegram = telegram
	end
	
	private
	
	#Сеттер номера с валидацией
	def phone=(phone)
		if Student.phone_valid?(phone)
			@phone = phone
		else
			puts "Invalid phone"
		end
	end

	#Сеттер телеги с валидацией
	def telegram=(telegram)
		if Student.telegram_valid?(telegram)
			@telegram = telegram
		else
			puts "Invalid telegram"
		end
	end

	#Сеттер почты с валидацией
	def email=(email)
		if Student.email_valid?(email)
			@email = email
		else
			puts "Invalid email"
		end
	end
end

class StudentShort
	attr_reader :id, :initials, :github, :contact
	def initialize(student)
		if student.is_a?(Student)
			@id = student.id if student.id
			@initials = "#{student.last_name} #{student.first_name[0].upcase}.#{student.middle_name[0].upcase}."
			@github = student.github if student.github
			@contact = 
			if student.phone
				"Телефон: #{student.phone}"
			elsif student.email
				"Почта: #{student.email}"
			elsif student.telegram
				"Телеграм: #{student.telegram}"
			end
		elsif student.is_a?(String)
			data = self.class.from_string(student)
			@id = data[:id] if data[:id]
			@initials = data[:initials]
			@github = data[:github] if data[:github]
			@contact = data[:contact] if data[:contact]
		end
	end

	def self.from_string(str)
		data = {}

		#Разбираем строку, заполняем хэш
		str.split(';').each do |pair|
			key, value = pair.split(': ').map(&:strip)
			case key
			when "Инициалы"
				data[:initials] = value
			when "GitHub"
				data[:github] = value
			when "Телефон", "Почта", "Телеграм"
				data[:contact] = "#{key}: #{value}"
			when "ID"
				data[:id] = value.to_i
			end
		end
		data
	end

	def display_info
		puts "ID: #{@id}" if id
		puts "Инициалы: #{@initials}"
		puts "GitHub: #{@github}" if github
		puts "#{@contact}" if contact
	end
end

#Создание через объект Student
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
student2 = StudentShort.new(student)
student2.display_info

#Создание через строку
student3 = StudentShort.new(student.get_info)
student3.display_info