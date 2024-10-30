require_relative 'StudentBase'

class StudentShort < StudentBase
  attr_reader :contact, :initials
  def initialize(student)
    super(id: student.id, github: student.github)
    self.initials = "#{student.last_name} #{student.first_name[0]}.#{student.middle_name[0]}."
    self.contact = student.contact
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
  private
  def initials=(initials)
    @initials = initials unless initials.nil?
  end

  def contact= (info)
    @contact = info unless info.nil?
  end
end