require_relative '../Adapter/adapter'
class StudentListAdapter < Adapter
  def initialize(strategy, file_path)
    @students_list = Student_List.new(file_path, strategy)
    @students_list.read
  end

  def get_by_id(student_id)
    @students_list.get_by_id(student_id)
  end

  def get_k_n_student_short_list(k, n, filter = nil)
    if filter.nil?
     @students_list.get_k_n_student_short_list(k, n)
    else
      @students_list.get_k_n_student_short_list(k, n, filter)
    end
  end

  def add_student(student)
    @students_list.add_student(student)
    @students_list.write
  end

  def update_student_by_id(student_id, student)
    @students_list.update_student_by_id(student_id, student)
    @students_list.write
  end

  def delete_student_by_id(student_id)
    @students_list.delete_student_by_id(student_id)
    @students_list.write
  end

  def get_student_count(filter = nil)
    if filter.nil?
      @students_list.get_student_count
    else
      @students_list.get_student_count(filter)
    end
  end
end
