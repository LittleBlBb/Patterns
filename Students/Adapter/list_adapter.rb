class ListAdapter
  def initialize(adapter)
    @adapter = adapter
  end

  def get_by_id(student_id)
    @adapter.get_by_id(student_id)
  end

  def get_k_n_student_short_list(k, n, filter = nil)
    @adapter.get_k_n_student_short_list(k, n, filter)
  end

  def add_student(student)
    @adapter.add_student(student)
  end

  def update_student_by_id(student_id, student)
    @adapter.update_student_by_id(student_id, student)
  end

  def delete_student_by_id(student_id)
    @adapter.delete_student_by_id(student_id)
  end

  def get_student_count(filter = nil)
    @adapter.get_student_count(filter)
  end
end
