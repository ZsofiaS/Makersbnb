class User

  attr_reader :username, :password, :realname, :email, :id

  def initialize(username, password, realname = nil, email = nil)
    @username = username
    @password = password
    @realname = realname
    @email = email
    @id =  nil
  end
end