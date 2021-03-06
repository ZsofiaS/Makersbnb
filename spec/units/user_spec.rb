require 'user'
require 'pg'

describe User do

  describe '#get_user_data' do
    it 'can return user object by username and password' do
      subject = User.new('Joe1984')
      expect(subject.id).to eq(1)
      expect(subject.realname).to eq('Joe Bloggs')
      expect(subject.username).to eq('Joe1984')
      expect(subject.email).to eq('joebloggs@hotmail.com')
    end
  end

  describe '#create' do
    it 'saves user in database' do
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345') #saves to database
      user2 = User.new('patrick')
      expect(user2.email).to eq ('pat@test.com')
      expect(user2.realname).to eq ('patrick sawyer')
    end
  end

  describe '#find' do
    it 'can return user object by id' do
      subject = User.find(1)
      expect(subject.id).to eq(1)
      expect(subject.realname).to eq('Joe Bloggs')
      expect(subject.username).to eq('Joe1984')
      expect(subject.email).to eq('joebloggs@hotmail.com')
    end
  end

  describe '#username and email test' do
    it 'returns false when username exist in db' do
      expect(User.username_and_email_test('Joe1984', 'random@hotmail.com')).to be false
    end
    it 'returns false when email exisits on db' do
      expect(User.username_and_email_test('random', 'joebloggs@hotmail.com')).to be false
    end
    it 'returns true when email and username are unique' do
      expect(User.username_and_email_test('random', 'random@hotmail.com')).to be true
    end
  end

  describe  '#authenticate' do
    it 'returns nil if password is incorrect' do
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345')
      expect(User.authenticate('patrick', 'wrongPassword')).to eq(nil)
    end
    it 'returns nil if username is incorrect' do
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345')
      expect(User.authenticate('wrongpatrick', '12345')).to eq(nil)
    end
    it 'returns User if both correct' do
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345')
      expect(User.authenticate('patrick', '12345')).to be_a User
    end
end
end
