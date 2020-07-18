require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(ENV['DATABASE_URL'])
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end


end
