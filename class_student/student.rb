class StudentBase
  attr_accessor :id
  attr_reader :github

  def initialize(id: nil, github: nil)
    self.id = id if id
    self.github = github if github
  end

  def github=(github)
    raise ArgumentError unless StudentBase.github_valid?(github)
    @github = github
  end

  # Валидация GitHub
  def self.github_valid?(github)
    github.match?(/\Ahttps:\/\/github.com\/[a-zA-Z0-9_-]+\z/)
  end
end

class Student < StudentBase
  attr_accessor :first_name, :last_name, :middle_name
  attr_reader :phone, :email, :telegram

  def initialize(first_name:, last_name:, middle_name:, phone: nil, email: nil, telegram: nil, id: nil, github: nil)
    super(id: id, github: github)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    set_contacts(phone: phone, email: email, telegram: telegram) if phone || email || telegram
  end

  def set_contacts(phone: nil, email: nil, telegram: nil)
    self.phone = phone if phone
    self.email = email if email
    self.telegram = telegram if telegram
  end

  def contact_info
    return "Телефон: #{@phone}" if phone
    return "Почта: #{@email}" if email
    return "Телеграм: #{@telegram}" if telegram
    "Контакт не указан"
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

  private

  def phone=(phone)
    raise ArgumentError unless Student.phone_valid?(phone)
    @phone = phone
  end

  def email=(email)
    raise ArgumentError unless Student.email_valid?(email)
    @email = email
  end

  def telegram=(telegram)
    raise ArgumentError unless Student.telegram_valid?(telegram)
    @telegram = telegram
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

  def self.from_string(str)
    data = from_string_base(str)
    str.split('; ').each do |pair|
      key, value = pair.split(': ').map(&:strip)
      case key
      when "ID"
        data[:id] = value.to_i
      when "GitHub"
        data[:github] = value
      end
    end
    Student.new(**data)
  end

  def self.from_string_base(str)
    data = {}
    str.split('; ').each do |pair|
      key, value = pair.split(': ').map(&:strip)
      case key
      when "Имя"
        data[:first_name] = value
      when "Фамилия"
        data[:last_name] = value
      when "Отчество"
        data[:middle_name] = value
      when "Телефон"
        data[:phone] = value
      when "Почта"
        data[:email] = value
      when "Телеграм"
        data[:telegram] = value
      end
    end
    data
  end
end

class StudentShort < StudentBase
  attr_reader :initials, :contact

  def initialize(student)
    super(id: student.id, github: student.github)
    @initials = "#{student.last_name} #{student.first_name[0]}.#{student.middle_name[0]}."
    @contact = student.contact_info
  end

  def to_s
    str = []
    str << "ID: #{@id}" if @id
    str << "Инициалы: #{@initials}"
    str << "Контакт: #{@contact}"
    str << "GitHub: #{@github}" if github
    str.join('; ')
  end

  def self.from_string(str, id: nil)
    data = Student.from_string_base(str)
    str.split('; ').each do |pair|
      key, value = pair.split(': ').map(&:strip)
      case key
      when "Инициалы"
        initials = value.split(' ')
        data[:last_name] = initials[0]
        name_parts = initials[1].split('.')
        data[:first_name] = name_parts[0]
        data[:middle_name] = name_parts[1]
      when "GitHub"
        data[:github] = value
      end
    end
    data[:id] = id if id

    student = Student.new(
      first_name: data[:first_name],
      last_name: data[:last_name],
      middle_name: data[:middle_name],
      id: data[:id],
      phone: data[:phone],
      email: data[:email],
      telegram: data[:telegram],
      github: data[:github]
    )
    StudentShort.new(student)
  end
end