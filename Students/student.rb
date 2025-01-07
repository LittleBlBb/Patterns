require_relative 'StudentBase'
require 'date'
class Student < StudentBase
  include Comparable
  attr_reader :phone, :email, :telegram, :first_name, :last_name, :middle_name, :birthdate

  def initialize(first_name:, last_name:, middle_name:, birthdate:, phone: nil, email: nil, telegram: nil, id: nil, github: nil)
    super(id: id, github: github)
    self.first_name = first_name
    self.last_name = last_name
    self.middle_name = middle_name
    set_contacts(phone: phone, email: email, telegram: telegram) if phone || email || telegram
    self.birthdate = birthdate
  end

  def <=>(other)
    if self.birthdate < other.birthdate
      return -1
    elsif self.birthdate == other.birthdate
      return 0
    else
      return 1  
    end
  end

  def ==(other)
    if self.phone && other.phone && self.phone == other.phone || self.email && other.email && self.email == other.email || self.telegram && other.telegram && self.telegram == other.telegram || self.github && other.github && self.github == other.github
      return true
    end
    return false
  end

  def birthdate=(birthdate)
    @birthdate = birthdate.is_a?(String) ? Date.parse(birthdate) : birthdate
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

  def has_contact?
    return true if self.contact
    false
  end

  def get_git_and_contact
    "GitHub: #{self.github} contact: #{self.contact}"
  end

  def contact
    return "Phone: #{@phone}" if phone
    return "Email: #{@email}" if email
    return "Telegram: #{@telegram}" if telegram
    nil
  end

  def self.from_hash(hash)
    Student.new(**hash)
  end

  def to_hash
    {
      id: @id,
      first_name: @first_name,
      last_name: @last_name,
      middle_name: @middle_name,
      birthdate: @birthdate,
      github: @github,
      contact: @contact,
      email: @email
    }
  end

  def to_s
    str = []
    str << "ID: #{@id}" if @id
    str << "Firstname: #{@first_name}"
    str << "Surname: #{@last_name}"
    str << "Lastname: #{@middle_name}"
    str << "Birthdate: #{@birthdate}"
    str << "Phone: #{@phone}" if phone
    str << "Telegram: #{@telegram}" if telegram
    str << "Email: #{@email}" if email
    str << "GitHub: #{@github}" if github
    str.join('; ')
  end

  def get_info
    info = []
    info << "Initials: #{@last_name} #{@first_name[0]}.#{@middle_name[0]}."
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
      when "ID"
        data[:id] = value.to_i
      when "Firstname"
        data[:first_name] = value
      when "Lastname"
        data[:last_name] = value
      when "Surname"
        data[:middle_name] = value
      when "Phone"
        data[:phone] = value
      when "Email"
        data[:email] = value
      when "Telegram"
        data[:telegram] = value
      when "Birthdate"
        data[:birthdate] = value
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

