require 'user'
require 'pg'

describe User do

  # describe 'variables' do
  #   it 'initialises the variables when login user' do
  #     user = User.new('patrick', '1984')
  #     expect(user.username).to eq('patrick')
  #     expect(user.password).to eq('12345')
  #     expect(user).to respond_to(:realname)
  #     expect(user).to respond_to(:email)
  #     expect(user).to respond_to(:id)
  #   end
  # end

  #split into 2 tests

  describe 'get_user_data' do 
    it 'can return user object by username and password' do
      subject = User.new('Joe1984', '12345')
      expect(subject.id).to eq(1)
      expect(subject.realname).to eq('Joe Bloggs')
      expect(subject.username).to eq('Joe1984')
      expect(subject.email).to eq('joebloggs@hotmail.com')
      expect(subject.password).to eq('12345')
    end
  end

  describe 'create' do 
    it 'saves user in database' do 
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345') #saves to database
      user2 = User.new('patrick', '12345')
      expect(user2.email).to eq ('pat@test.com')
      expect(user2.realname).to eq ('patrick sawyer')
    end
  end

  describe 'find' do
    it 'can return user object by id' do
      subject = User.find(1)
      expect(subject.id).to eq(1)
      expect(subject.realname).to eq('Joe Bloggs')
      expect(subject.username).to eq('Joe1984')
      expect(subject.email).to eq('joebloggs@hotmail.com')
    end
  end
end