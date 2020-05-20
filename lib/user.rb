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
    if self.username_and_email_test(username, email)
      DatabaseConnection.query("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{password}');")
      true
    else
      false
    end
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

  def self.username_and_email_test(username, email)
    response = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}' OR email = '#{email}'")
    !response.any?
  end
end