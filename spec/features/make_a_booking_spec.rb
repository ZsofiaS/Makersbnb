feature "Making a booking" do
  scenario "User requests a booking" do
    visit("/spaces/1")
    expect(page).to have_content("Request booking")
  end

  scenario 'User can select dates' do
    visit('/spaces/1')
    expect(page).to have_select('month')
  end

end
