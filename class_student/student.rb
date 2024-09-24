class Student
  attr_accessor :id, :last_name, :middle_name, :first_name
  attr_reader :phone, :telegram, :email, :github

  def initialize(id: nil, first_name:, last_name:, middle_name:, phone: nil, telegram: nil, email: nil, github: nil)
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
    data
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
        students << Student.new(**Student.from_string(line.strip))
      end
      students
    #Записываем объект ошибки в переменную
    rescue => e
      puts "Ошибка: #{e.message}"
    end
  end

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
    if Student.phone_valid?(phone)
      @phone = phone
    else
      puts "Invalid phone"
    end
  end

  def telegram=(telegram)
    if Student.telegram_valid?(telegram)
      @telegram = telegram
    else
      puts "Invalid telegram"
    end
  end

  def email=(email)
    if Student.email_valid?(email)
      @email = email
    else
      puts "Invalid email"
    end
  end

  def github=(github)
    if Student.github_valid?(github)
      @github = github
    else
      puts "Invalid GitHub"
    end
  end

  # Валидации
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
  attr_reader :initials, :contact

  def initialize(student)
    if student.is_a?(Student)
      super(
        id: student.id,
        first_name: student.first_name,
        last_name: student.last_name,
        middle_name: student.middle_name,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github
      )
      @initials = "#{student.last_name} #{student.first_name[0].upcase}.#{student.middle_name[0].upcase}."
      @contact = student.contact_info
    elsif student.is_a?(String)
      data = Student.from_string(student)
      super(
        id: data[:id],
        first_name: data[:first_name],
        last_name: data[:last_name],
        middle_name: data[:middle_name],
        phone: data[:phone],
        telegram: data[:telegram],
        email: data[:email],
        github: data[:github]
      )
      @initials = "#{@last_name} #{@first_name[0].upcase}.#{@middle_name[0].upcase}."
      @contact = contact_info
    end
  end

  def display_info
    puts "ID: #{@id}" if id
    puts "Инициалы: #{@initials}"
    puts "GitHub: #{@github}" if @github
    puts "#{@contact}" if @contact
  end
end