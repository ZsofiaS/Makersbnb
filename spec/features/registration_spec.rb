feature 'registration' do 
  scenario ' a user can sign up' do
    visit('/users/new')
    fill_in('email', with: 'test@test.test')
    fill_in('username', with: 'test')
    fill_in('name', with: 'testpat')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_content 'Please log in'
    # expect(page).to have_content 'test'
    # expect(page).to have_content '12345'

  end
  scenario ' a user can log in' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_current_path("/spaces", url: false)
  end

  #add test for wrong password or username

end



