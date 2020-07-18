require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(ENV["HEROKU_POSTGRESQL_SILVER_URL"])
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end


end
