require_relative 'db_connection'

class Seeder
  def self.run
    db = DB_Connection.new('students.db')

    Dir["./seeds/*.sql"].each do |file|
      puts "Seeding #{file}"
      db.execute_script(file)
    end

    db.close
  end
end

Seeder.run if __FILE__ == $0