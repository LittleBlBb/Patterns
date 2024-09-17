class Student
	#Удобная штука, которая автоматически создает геттеры, сеттеры для всех полей
	attr_accessor :id, :last_name, :first_name, :middle_name
	#Автоматом делает геттеры
	attr_reader :phone, :telegram, :email, :github
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

	#Сеттер гита с валидацией
	def github=(github)
		if Student.github_valid?(github)
			@github = github
		else
			puts "Invalid github"
		end
	end

	#Валидация номера телефона
	def self.phone_valid?(phone)
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
		errors << "Github не указан в профиле студента" unless git_present?
		errors << "Контакты не указаны в профиле студента" unless contact_present?
		
		if errors.empty?
			puts "Валидация пройдена"
		else
			puts "Валидация не пройдена\nОшибки валидации:"
			errors.each{|error| puts error}
		end
	end
end