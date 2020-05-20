require 'pg'

class DatabaseConnection
  def self.setup(dbname)
    @connection = PG.connect(dbname: 'spaced_out_test')
  end

  def self.connection
    @connection
  end

  def self.query(sql)
    @connection.exec(sql)
  end

  
end
