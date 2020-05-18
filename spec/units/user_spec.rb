require 'user'

describe 'User' do

  login_user = User.new('tanil', '12345');
  signup_user = User.new('patrick', '12345', 'patrick sawyer', 'patrick@hotmail.co.uk')

  describe 'variables' do
    it 'initialises the variables when login user' do
      expect(login_user.username).to eq ('tanil')
      expect(login_user.password).to eq ('12345')
      expect(login_user).to respond_to(:realname)
      expect(login_user).to respond_to(:email)
      expect(login_user).to respond_to(:id)
    end
    it 'initialises variables when signup_user' do 
      expect(signup_user.username).to eq ('patrick')
      expect(signup_user.password).to eq ('12345')
      expect(signup_user.email).to eq ('patrick@hotmail.co.uk')
      expect(signup_user.realname).to eq ('patrick sawyer')
      expect(login_user).to respond_to(:id)
    end
  end
end



