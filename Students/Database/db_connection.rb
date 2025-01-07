require 'pg'
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
    @db = PG::Connection.open(
      dbname: 'students',
      user: 'postgres',
      password: '123',
      host: 'localhost',
      port: 5432
    )

  end

  def execute(query, params = [])
    @db.exec_params(query, params)
  end

  def execute_script(file_path)
    script = File.read(file_path)
    @db.exec(script)
  end

  def close
    @db.close if @db
  end

  private_class_method :new

  def initialize(db_name)
    @db_name = db_name
    connect
  end
end