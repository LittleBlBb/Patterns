class Student
  attr_accessor :id, :last_name, :middle_name, :first_name
  attr_reader :phone, :telegram, :email, :github

  def initialize(first_name:, last_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil, id: nil)
    @id = id
    @last_name = last_name
    @first_name = first_name
    @middle_name = middle_name
    set_contacts(phone: phone, telegram: telegram, email: email) if (phone || telegram || email)
    self.github = github if github
  end

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
    str.join('; ')
  end

  def get_info
    info = []
    info << "Инициалы: #{@last_name} #{@first_name[0]}.#{@middle_name[0]}."
    info << "GitHub: #{@github}" if github
    info << contact_info
    info.compact.join('; ')
  end

  def contact_info
    if phone
      "Телефон: #{@phone}"
    elsif email
      "Почта: #{@email}"
    elsif telegram
      "Телеграм: #{@telegram}"
    end
  end

  def self.from_string(str)
    data = {}
    raise "Ошибка парсинга строки: Строка пустая, нечего парсить." if str.nil? || str.strip.empty?
    str.split('; ').each do |pair|
      key, value = pair.split(': ').map(&:strip)
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
      when "Инициалы"
        initials = value.split(' ')
        data[:last_name] = initials[0]
        initials_split = initials[1].split('.')
        data[:first_name] = initials_split[0]
        data[:middle_name] = initials_split[1]
      end
    end
    Student.new(**data)
  end

  def set_contacts(phone: nil, email: nil, telegram: nil)
    self.phone = phone if phone
    self.email = email if email
    self.telegram = telegram if telegram
  end

  def self.read_from_txt(path)
    begin
      #Выкидываем ошибку
      raise "Файл не найден или некоррекный путь: #{path}" unless File.exist?(path)
      students = []
      #Читаем файл построчно
      File.readlines(path).each do |line|
        #Проверяем строки, пустые или нет
        next if line.strip.empty?
        students << Student.from_string(line.strip)
      end
      students
    #Записываем объект ошибки в переменную
    rescue => e
      puts "Ошибка: #{e.message}"
    end
  end

  def self.write_to_txt(path, students)
    begin
      File.open(path, 'w') do |file|
        students.each do |student|
          file.puts student.to_s
        end
      end
    rescue => e
      puts "Ошибка записи в файл: #{e.message}"
    end
  end

  private

  def phone=(phone)
    begin
      raise "Invalid phone" unless Student.phone_valid?(phone)
      @phone = phone
    rescue => e
      puts "Ошибка валидации телефона: #{e.message}"
    end
  end

  def telegram=(telegram)
    begin
      raise "Invalid telegram" unless Student.telegram_valid?(telegram)
      @telegram = telegram
    rescue => e
      puts "Ошибка валидации телеграма: #{e.message}"
    end
  end

  def email=(email)
    begin 
      raise "Invalid email" unless Student.email_valid?(email)
      @email = email
    rescue => e
      puts "Ошибка валидации почты: #{e.message}"
    end
  end

  def github=(github)
    begin
      raise "Invalid GitHub" unless Student.github_valid?(github)
      @github = github
    rescue => e
      puts "Ошибка валидации гита: #{e.message}"
    end
  end

  # Валидации
  def self.id_valid?(id)
    id.is_a?(Ineger) && id > 0
  end

  def self.first_name_valid?(first_name)
    first_name.match?(/\A[А-Яа-яA-Za-z]+(?:-[А-Яа-яA-Za-z]+)?\z/)
  end

  def self.last_name_valid?(last_name)
    last_name.match?(/\A[А-Яа-яA-Za-z]+(?:-[А-Яа-яA-Za-z]+)?\z/)
  end

  def self.middle_name_valid?(middle_name)
    middle_name.match?(/\A[А-Яа-яA-Za-z]+(?:-[А-Яа-яA-Za-z]+)?\z/)
  end

  def self.phone_valid?(phone)
    phone.match?(/^\+?\d{10,12}$/)
  end

  def self.email_valid?(email)
    email.match?(/\A[^@\s]+@[^@\s]+\.[^@\s]+\z/)
  end

  def self.telegram_valid?(telegram)
    telegram.match?(/\A@[a-zA-Z0-9_]{5,}\z/)
  end

  def self.github_valid?(github)
    github.match?(/\Ahttps:\/\/github.com\/[a-zA-Z0-9_-]+\z/)
  end
end

class StudentShort < Student
  attr_reader :initials, :contact, :id, :github

  def initialize(student)
    @id = student.id if student.id
    @initials = "#{student.last_name} #{student.first_name[0]}.#{student.middle_name[0]}."
    @contact = student.contact_info || "Контакт не указан"
    @github = student.github if student.github
  end

  # Метод from_string для обработки строк разных типов
  def self.from_string(string, id: nil)
    data = {}

    # Разбиваем строку на компоненты
    string.split('; ').each do |pair|
      key, value = pair.split(': ').map(&:strip)
      case key
      when "ID"
        data[:id] = value.to_i
      when "Инициалы"
        initials = value.split(' ')
        data[:last_name] = initials[0]
        data[:first_name], data[:middle_name] = initials[1].split('.').map(&:strip)
      when "Имя"
        data[:first_name] = value
      when "Фамилия"
        data[:last_name] = value
      when "Отчество"
        data[:middle_name] = value
      when "Телефон", "Почта", "Телеграм"
        data[:contact] = value
      when "GitHub"
        data[:github] = value
      end
    end

    # Создаем объект Student
    student = Student.new(
      first_name: data[:first_name],
      last_name: data[:last_name],
      middle_name: data[:middle_name],
      phone: data[:contact],
      github: data[:github]
    )

    # Устанавливаем ID, если он передан напрямую или найден в строке
    student.id = data[:id] || id  # Теперь ID устанавливается, даже если оно передано как аргумент

    # Возвращаем объект StudentShort
    StudentShort.new(student)
  end

  def to_s
    str = []
    str << "ID: #{@id}" if @id  # Вывод ID если он установлен
    str << "Инициалы: #{@initials}"
    str << "Контакт: #{@contact}"
    str << "GitHub: #{@github}" if github
    str.join('; ')
  end
end

