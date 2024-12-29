require_relative 'db_connection'

class DBTester
  def self.test
    db = DB_Connection.new('students.db')

    rows = db.execute("SELECT * FROM student;")
    puts "students in database:"
    rows.each do |row|
      puts row.inspect
    end
    db.close
  end
end

DBTester.test if __FILE__ == $0