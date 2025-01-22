class Adapter
  def get_by_id(student_id)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end

  def get_k_n_student_short_list(k, n, filter = nil)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end

  def add_student(student)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end

  def update_student_by_id(student_id, student)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end

  def delete_student_by_id(student_id)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end

  def get_student_count(filter = nil)
    raise NotImplementedError, "Method not implemented in #{self.class.name}"
  end
end
