require_relative 'student'
require_relative 'StudentShort'
require_relative 'Data_list/Data_list_student_short'

class Student_List
  def initialize(file_path, strategy)
    @file_path = file_path
    @strategy = strategy
    @students = read
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
    student
  end

  def update_student_by_id(student_id, updated_student)
    start_index = @students.find_index {|student| student.id == student_id}

    if start_index.nil?
      raise "Student with ID #{student_id} not found"
    end

    updated_student.id = student_id
    @students[start_index] = updated_student
    true
  end

  def delete_student_by_id(student_id)
    @students.reject! {|student| student.id == student_id}
  end

  def get_student_count
    @students.count {|student| student.class == Student}
  end

  def read
    @strategy.read(@file_path)
  end

  def write
    @strategy.write(@file_path, @students)
  end

  protected

  attr_reader :file_path

  def file_path=(file_path)
    raise "Файл не найден или некорректный путь: #{file_path}" unless File.exist?(file_path)
    @file_path = file_path
  end
end
