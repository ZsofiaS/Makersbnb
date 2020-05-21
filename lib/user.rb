require_relative 'database_connection'
require 'bcrypt'

class User

  include BCrypt

  attr_reader :username, :realname, :email, :id

  def initialize(username)
    @username = username
    @realname
    @email
    @id
    get_user_data
  end

  def self.create(username, name, email, password)
    if self.username_and_email_test(username, email)
      DatabaseConnection.query("INSERT INTO users (username, name, email, password) VALUES ('#{username}', '#{name}', '#{email}', '#{BCrypt::Password.create(password)}');")
      true
    else
      false
    end
  end

  def self.find(id)
    response = DatabaseConnection.query("SELECT * FROM users WHERE id = #{id}")
    user = User.new(response[0]['username'])
  end

  def self.authenticate(username, password)
    response = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{username}';")
    return unless response.any?
    return unless BCrypt::Password.new(response[0]['password']) == password
    User.new(response[0]['username'])
  end

  private

  def get_user_data
    response = DatabaseConnection.query("SELECT * FROM users WHERE username = '#{@username}';")
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
