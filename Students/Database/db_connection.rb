require 'sqlite3'

class DB_Connection

  attr_reader :db

  @instance = nil

  def self.instance(db_name)
    if @instance == nil
      @instance = new(db_name)
    end
    @instance
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

  private_class_method :new

  def initialize(db_name)
    @db_name = db_name
    connect
  end
end