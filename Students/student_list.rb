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

  def get_k_n_student_short_list(k, n, filter = nil)
    start_index = (k - 1) * n
    end_index = start_index + n - 1
    short_students = @students[start_index, end_index] || []
    short_students = filter.apply_filter(short_students) if filter

    short_students = short_students.map { |student| StudentShort.new(student) }

    selected_list = Data_list_student_short.new(short_students)
    short_students.each_with_index {|_, ind| selected_list.select(ind) }
    selected_list
  end

  def sort_by_initials
    @students.sort_by!(&:last_name)
  end

  def add_student(student)
    equal_check(student)
    new_id = (@students.map(&:id).max || 0) + 1
    student.id = new_id
    @students << student
  end

  def update_student_by_id(student_id, updated_student)
    equal_check(updated_student)
    index = @students.find_index {|student| student.id == student_id}

    if index.nil?
      raise "Student with ID #{student_id} not found"
    end

    updated_student.id = student_id
    @students[index] = updated_student
    true
  end

  def delete_student_by_id(student_id)
    @students.reject! {|student| student.id == student_id}
  end

  def get_student_count(filter = nil)
    filtered_students = filter ? filter.apply_filter(@students) : @students
    filtered_students.size
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

  def equal_check(student)
    if @students.any? {|st| st == student }
      raise ArgumentError, "Student with the same contact or github is already exists"
    end
  end
end