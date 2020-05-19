require 'user'
require 'pg'

describe User do
  describe 'variables' do
    it 'initialises the variables when login user' do
      expect(subject).to respond_to(:username)
      expect(subject).to respond_to(:password)
      expect(subject).to respond_to(:realname)
      expect(subject).to respond_to(:email)
      expect(subject).to respond_to(:id)
    end
  end

  describe 'create' do 
    it 'saves user in database' do 
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345')
      user = User.new('patrick', '123245')
      expect(user.email).to eq ('pat@test.com')
      expect(user.password).to eq ('12345')
      expect(user.username).to eq ('patrick')
      expect(user.realname).to eq ('patrick sawyer')
    end
  end
end



