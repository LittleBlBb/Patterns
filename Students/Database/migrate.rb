require_relative 'db_connection'

class Migrator
  def self.run
    db = DB_Connection.new('students.db')

    Dir["./migrations/*.sql"].each do |file|
      puts "Migrating #{file}"
      db.execute_script(file)
    end

    db.close
  end
end

Migrator.run if __FILE__ == $0