require_relative 'StudentBase'

class Student < StudentBase
  attr_reader :phone, :email, :telegram, :first_name, :last_name, :middle_name

  def initialize(first_name:, last_name:, middle_name:, phone: nil, email: nil, telegram: nil, id: nil, github: nil)
    super(id: id, github: github)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    set_contacts(phone: phone, email: email, telegram: telegram) if phone || email || telegram
  end

  def first_name=(first_name)
    raise ArgumentError, "Некорректное имя" unless Student.name_valid?(first_name)
    @first_name = first_name
  end

  def last_name=(last_name)
    raise ArgumentError, "Некорректная фамилия" unless Student.name_valid?(last_name)
    @last_name = last_name
  end

  def middle_name=(middle_name)
    raise ArgumentError, "Некорректное отчество" unless Student.name_valid?(middle_name)
    @middle_name = middle_name
  end

  def set_contacts(phone: nil, email: nil, telegram: nil)
    self.phone = phone if phone
    self.email = email if email
    self.telegram = telegram if telegram
  end

  def contact    
    return "Телефон: #{@phone}" if phone
    return "Почта: #{@email}" if email
    return "Телеграм: #{@telegram}" if telegram
    nil
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
    info << contact
    info.compact.join('; ')
  end

  # Валидации
  def self.name_valid?(name)
    name.match?(/\A[А-Яа-яёЁA-Za-z]+\z/)
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
end