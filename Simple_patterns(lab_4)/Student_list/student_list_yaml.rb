require 'yaml'
require 'date'
require_relative '../Student_list/student_list'

class Student_list_YAML < Student_List

  def read_from_file
    if File.exist?(@file_path)
      file_content = File.read(@file_path)
      student_data = YAML.safe_load(
        file_content,
        permitted_classes: [Symbol, Date],
        symbolize_names: true
      )
      @students = student_data.map do |data|
        data[:birthdate] = data[:birthdate].to_s if data[:birthdate].is_a?(Date)
        Student.new(**data)
      end
    else
      @students = []
    end
  end

  def write_to_file
    serialized_data = @students.map do |student|
      {
        id: student.id,
        last_name: student.last_name,
        first_name: student.first_name,
        middle_name: student.middle_name,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github,
        birthdate: student.birthdate.to_s
      }
    end
    File.open(@file_path, 'w') do |file|
      file.write(serialized_data.to_yaml)
    end
  end
end