require_relative '../Students/Database/db_connection'
require_relative '../Students/Data_list/Data_list_student_short'

class Students_list_DB
  def initialize(db_connection)
    @db = db_connection
  end
  def get_by_id(student_id)
    query_result = @db.execute("SELECT * FROM Student WHERE id = #{student_id};")
    nil if query_result.empty?

    row = query_result.first
    Student.new(
      id: row[0].to_i,
      last_name: row[1],
      first_name: row[2],
      middle_name: row[3],
      phone: row[4],
      email: row[5],
      telegram: row[6],
      github: row[7],
      birthdate: row[8]
    )
  end

  def get_k_n_student_short_list (k, n)
    start_index = (k - 1) * n
    end_index = start_index + n - 1
    query_result = @db.execute("SELECT * FROM Student WHERE id BETWEEN #{start_index} AND #{end_index};")
    students = query_result.map do |row|
      Student.new(
        id: row[0].to_i,
        last_name: row[1],
        first_name: row[2],
        middle_name: row[3],
        phone: row[4],
        email: row[5],
        telegram: row[6],
        github: row[7],
        birthdate: row[8]
      )
    end
    students_short = students.map do |student|
      StudentShort.new(student)
    end
    selected_list = Data_list_student_short.new(students_short)
    students_short.each_with_index do |_, index| selected_list.select(index)
    selected_list
    end
  end

  def add_student(student)
    @db.execute("
    INSERT INTO student (last_name, first_name, middle_name, phone, email, telegram, github, birthdate)
    VALUES(
            '#{student.last_name}',
            '#{student.first_name}',
            '#{student.middle_name}',
            #{student.phone.nil? ? "NULL" : "'#{student.phone}'"},
            #{student.email.nil? ? "NULL" : "'#{student.email}'"},
            #{student.telegram.nil? ? "NULL" : "'#{student.telegram}'"},
            #{student.github.nil? ? "NULL" : "'#{student.github}'"},
            '#{student.birthdate}'
          );
  ")
  end


  def update_student_by_id(student_id, student)
    @db.execute("
    UPDATE student
    SET
            last_name = '#{student.last_name}',
            first_name = '#{student.first_name}',
            middle_name = '#{student.middle_name}',
            phone = '#{student.phone.nil? ? "NULL" : "#{student.phone}"}',
            email = '#{student.email.nil? ? "NULL" : "#{student.email}"}',
            telegram = '#{student.telegram.nil? ? "NULL" : "#{student.telegram}"}',
            github = '#{student.github.nil? ? "NULL" : "#{student.github}"}',
            birthdate = '#{student.birthdate}'
    WHERE id = #{student_id};
    ")
  end

  def delete_student_by_id(student_id)
    @db.execute("DELETE FROM student WHERE id = #{student_id};")
  end

  def get_student_count
    @db.execute("SELECT COUNT(*) FROM student;")
  end
end
