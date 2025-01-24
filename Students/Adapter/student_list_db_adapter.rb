require_relative '../Adapter/adapter'
require_relative '../Data_list/Data_list_student_short'

class StudentListDBAdapter < Adapter

  def initialize(db_name)
    @db = DB_Connection.instance(db_name)
  end

  def get_by_id(student_id)
    query_result = @db.execute("SELECT * FROM student WHERE id = $1;", [student_id])
    return nil if query_result.nil? || query_result.ntuples.zero?
    row = query_result.first
    Student.new(
      id: row["id"].to_i,
      last_name: row['last_name'],
      first_name: row['first_name'],
      middle_name: row['middle_name'],
      phone: row['phone'],
      email: row['email'],
      telegram: row['telegram'],
      github: row['github'],
      birthdate: row['birthdate']
    )
  end

  def get_k_n_student_short_list(k, n, filter = nil)
    offset = (k - 1) * n
    query_result = @db.execute("SELECT * FROM Student ORDER BY id LIMIT #{n} OFFSET #{offset}")
    students = query_result.map do |row|
      Student.from_hash(
        id: row["id"].to_i,
        last_name: row['last_name'],
        first_name: row['first_name'],
        middle_name: row['middle_name'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        github: row['github'],
        birthdate: row['birthdate']
      )
    end
    students = filter.apply_filter(students) if filter
    short_students = students.map { |student| StudentShort.new(student) }
    selected_list = Data_list_student_short.new(short_students)
    short_students.each_with_index { |_, ind| selected_list.select(ind) }
    selected_list
  end

  def add_student(student)
    begin
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
    rescue PG::Error => e
      handle_database_error(e)
    end
  end

  def update_student_by_id(student_id, student)
    begin
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
    rescue PG::Error => e
      handle_database_error(e)
    end
  end

  def delete_student_by_id(student_id)
    @db.execute("DELETE FROM student WHERE id = #{student_id};")
  end

  def get_student_count(filter = nil)
    result = @db.execute("SELECT * FROM student;")
    students = result.map do |row|
      Student.from_hash(
        id: row['id'].to_i,
        last_name: row['last_name'],
        first_name: row['first_name'],
        middle_name: row['middle_name'],
        phone: row['phone'],
        email: row['email'],
        telegram: row['telegram'],
        github: row['github'],
        birthdate: row['birthdate']
      )
    end
    filtered_students = filter ? filter.apply_filter(students) : students
    filtered_students.size
  end

  def handle_database_error(exception)
    if exception.is_a?(PG::UniqueViolation)
      if exception.message.include?("student_github_key")
        puts "Ошибка: студент с таким GitHub уже есть."
      elsif exception.message.include?("student_email_key")
        puts "Ошибка: студент с таким Email уже есть."
      elsif exception.message.include?("student_telegram_key")
        puts "Ошибка: студент с таким Telegram уже есть."
      elsif exception.message.include?("student_phone_key")
        puts "Ошибка: студент с таким номером телефона уже есть."
      else
        puts "Ошибка уникальности: #{exception.message}"
      end
    else
      puts "Произошла ошибка базы данных: #{exception.message}"
    end
  end
end