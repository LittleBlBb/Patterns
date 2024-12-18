require 'json'
require_relative '../Student_list/student_list'
class Student_list_JSON < Student_List

  def read_from_file
    if File.exist?(@file_path)
      file_content = File.read(@file_path)
      student_data = JSON.parse(file_content, symbolize_names: true)
      @students = student_data.map{ |data| Student.new(**data) }
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
        birthdate: student.birthdate
      }
    end
    File.open(@file_path, 'w') do |file|
      file.write(JSON.pretty_generate(serialized_data))
    end
  end
end