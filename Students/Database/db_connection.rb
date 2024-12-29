require 'sqlite3'

class DB_Connection

  attr_reader :db

  def initialize(db_name)
    @db_name = db_name
    connect
  end

  def connect
    @db = SQLite3::Database.new(@db_name)
  end

  def execute(query, params = [])
    @db.execute(query, params)
  end

  def execute_script(file_path)
    script = File.read(file_path)
    @db.execute_batch(script)
  end

  def close
    @db.close
  end
end