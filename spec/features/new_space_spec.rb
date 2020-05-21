feature 'new space' do
  scenario 'user can add new space' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    visit('/spaces/new')
    fill_in('name', with: 'test space title')
    fill_in('description', with: 'here is a space description')
    fill_in('price_per_night', with: '120.43')
    fill_in('available_from', with: '01-01-2020')
    fill_in('available_to', with: '30-01-2020')
    click_button('submit')
    expect(page).to have_content('test space title')
    expect(page).to have_content('here is a space description')
    expect(page).to have_content('$120.43')
    expect(page).to have_content('01-01-2020')
    expect(page).to have_content('30-01-2020')
    expect(page).to have_content('User id: 1')
  end
end