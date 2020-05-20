feature 'sign up' do 
  scenario ' a user can sign up' do
    visit('/users/new')
    fill_in('email', with: 'test@test.test')
    fill_in('username', with: 'test')
    fill_in('name', with: 'testpat')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_content('Please log in')
    expect(page).to have_current_path("/users/log-in", url: false)
  end

  scenario ' a user cannot sign up if username taken' do
    visit('/users/new')
    fill_in('email', with: 'test@test.test')
    fill_in('username', with: 'Joe1984')
    fill_in('name', with: 'testpat')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_content("Email or username already taken")
    expect(page).to have_current_path("/users/new", url: false)
  end

  scenario ' a user cannot sign up if email taken' do
    visit('/users/new')
    fill_in('email', with: 'joebloggs@hotmail.com')
    fill_in('username', with: 'test')
    fill_in('name', with: 'testpat')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_content("Email or username already taken")
    expect(page).to have_current_path("/users/new", url: false)
  end
end

feature 'log-in' do
  scenario ' a user can log in' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_current_path("/spaces", url: false)
  end

  scenario ' a user cant log in with wrong username' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1983')
    fill_in('password', with: '12345')
    click_button('submit')
    expect(page).to have_content("Username or password is incorrect")
    expect(page).to have_content 'Please log in'
    expect(page).to have_current_path("/users/log-in", url: false)
  end

  scenario ' a user cant log in with wrong password' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1983')
    fill_in('password', with: '12346')
    click_button('submit')
    expect(page).to have_content("Username or password is incorrect")
    expect(page).to have_content 'Please log in'
    expect(page).to have_current_path("/users/log-in", url: false)
  end
end



