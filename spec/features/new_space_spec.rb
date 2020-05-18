feature 'new space' do
  scenario 'user can add new space' do
    visit('/spaces/new')
    fill_in('name', with: 'test space title')
    click_button('submit')
    expect(page).to have_content('test space title')
  end
end