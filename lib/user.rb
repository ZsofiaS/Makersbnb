require 'pg'

class User

  attr_reader :username, :password, :realname, :email, :id

  def initialize(username, password)
    @username = username
    @password = password
    @realname
    @email
    @id
  end

  def self.create(username, name, email, password)
    ENV['ENVIRONMENT'] == 'test' ? db = 'spaced_out_test' : db = 'spaced_out'
    connection = PG.connect :dbname => db
    connection.exec("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password}');")
  end

  def get_user_data
    ENV['ENVIRONMENT'] == 'test' ? db = 'spaced_out_test' : db = 'spaced_out'
    connection = PG.connect :dbname => db
    response = connection.exec("SELECT * FROM users WHERE username = '#{@username}' AND password = '#{@password}';")
    if !response.count.zero?
      @id = response[0]['id']
      @realname = response[0]['name']
      @email = response[0]['email']
    else
      return false
    end
  end
end