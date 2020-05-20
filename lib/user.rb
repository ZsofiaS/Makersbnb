require_relative 'database_connection'

class User

  attr_reader :username, :password, :realname, :email, :id

  def initialize(username, password)
    @username = username
    @password = password
    @realname
    @email
    @id
    get_user_data
  end

  def self.create(username, name, email, password)
    # add test for clash of username or email
    DatabaseConnection.query("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password}');")
  end

  def self.find(id)
    response = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id}")
    User.new(response[0]['username'], response[0]['password'])
  end

  private

  def get_user_data
    response = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{@username}' AND password = '#{@password}';")  
    if response.any?
      @id = response[0]['id'].to_i
      @realname = response[0]['name']
      @email = response[0]['email']
    end
  end

  # def username_and_email_test

  # end
end