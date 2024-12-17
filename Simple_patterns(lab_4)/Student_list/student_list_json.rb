require_relative '../../class_student/StudentShort'
require_relative '../../class_student/student'
require_relative '../Data_list_student_short'
require 'json'
class Student_list_JSON
  attr_reader :file_path

  def initialize(file_path)
    @file_path = file_path
    @students = []
    read_from_file
  end

  def file_path=(file_path)
    raise "Файл не найден или некорректный путь: #{file_path}" unless File.exist?(file_path)
    @file_path = file_path
  end

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

  def get_by_id(student_id)
    received = @students.find {|student| student.id == student_id}
    raise IndexError, "В списке такого номера нет" unless received
    received
  end

  def get_k_n_student_short_list(k, n, existing_data_list = nil)
    start_index = (k - 1) * n
    end_index = start_index + n - 1
    short_students = @students[start_index, end_index] || []
    return existing_data_list || Data_list_student_short.new([]) if short_students.empty?
    short_students = short_students.map { |student| StudentShort.new(student) }

    if existing_data_list
      existing_data_list.data = short_students
      short_students.each_with_index {|_, ind| existing_data_list.select(ind) }
      return existing_data_list
    end
    selected_list = Data_list_student_short.new(short_students)
    short_students.each_with_index {|_, ind| selected_list.select(ind) }
    selected_list
  end

  def sort_by_initials
    @students.sort_by!(&:last_name)
  end

  def add_student(student)
    new_id = (@students.map(&:id).max || 0) + 1
    student.id = new_id
    @students << student
    write_to_file
    student
  end

  def update_student_by_id(student_id, updated_student)
    start_index = @students.find_index {|student| student.id == student_id}

    if start_index.nil?
      raise "Student with ID #{student_id} not found"
    end

    updated_student.id = student_id
    @students[start_index] = updated_student
    write_to_file
    true
  end

  def delete_student_by_id(student_id)
    @students.reject! {|student| student.id == student_id}
    write_to_file
  end

  def get_student_count
    @students.count {|student| student.class == Student}
  end
end

file_path = 'C:\Users\Kertis\Desktop\Ruby\Simple_patterns(lab_4)\Student_list\students.json'
student_list = Student_list_JSON.new(file_path)

st1 = Student.new(
  last_name: "Ivanov",
  first_name: "Ivan",
  middle_name: "Ivanovich",
  id: 1,
  phone: "+79121212122",
  telegram: "@example",
  email: "Test@example.com",
  github: "https://github.com/test",
  birthdate: "November 14 2004"
)
st2 = Student.new(
  last_name: "Joker",
  first_name: "Alexandr",
  middle_name: "Gartenovich",
  id: 2,
  phone: "+79558896464",
  telegram: "@Joker",
  email: "Joker@example.com",
  github: "https://github.com/Joker",
  birthdate: "03.03.2000"
)

# student_list.add_student(st1)
# student_list.add_student(st2)

puts student_list.get_by_id(1)

short_list = student_list.get_k_n_student_short_list(1, 2)
puts "Список:"
puts short_list.get_data

puts student_list.sort_by_initials

st3 = Student.new(
  last_name: "Zadikyan",
  first_name: "Avonya",
  middle_name: "Egyptyan",
  id: 3,
  phone: "+78005553535",
  telegram: "@AWP_Lego_2",
  email: "Armyanchick@ARM.com",
  github: "https://github.com/AVTSS",
  birthdate: "03.03.2004"
)
# student_list.update_student_by_id(3, st3)

# student_list.delete_student_by_id(4)

puts student_list.get_student_count