require_relative 'database_connection'

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
    # ENV['ENVIRONMENT'] == 'test' ? db = 'spaced_out_test' : db = 'spaced_out'
    # connection = PG.connect :dbname => db
    # add test for clash of username or email
    DatabaseConnection.query("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password}');")
  end

  def get_user_data
    # ENV['ENVIRONMENT'] == 'test' ? db = 'spaced_out_test' : db = 'spaced_out'
    # connection = PG.connect :dbname => db
    response = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{@username}' AND password = '#{@password}';")  
    if response.any?
      @id = response[0]['id']
      @realname = response[0]['name']
      @email = response[0]['email']
    else
      false # this bit needs to do something
    end
  end

  private

  # def password_test

  # end

  # def username_and_email_test

  # end
end