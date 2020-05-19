require 'user'
require 'pg'

describe User do

  user = User.new('patrick', '12345')

  describe 'variables' do
    it 'initialises the variables when login user' do
      expect(user.username).to eq('patrick')
      expect(user.password).to eq('12345')
      expect(user).to respond_to(:realname)
      expect(user).to respond_to(:email)
      expect(user).to respond_to(:id)
    end
  end

  describe 'create' do 
    it 'saves user in database' do 
      User.create('patrick', 'patrick sawyer', 'pat@test.com', '12345') #saves to database
      user.get_user_data # gets data from database
      expect(user.email).to eq ('pat@test.com')
      expect(user.realname).to eq ('patrick sawyer')
      # expect(user.id).to be_a('Number')
    end
  end
end



