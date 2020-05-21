feature "Making a booking" do

  before(:each) do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
  end

  scenario "User requests a booking" do
    visit("/spaces/1")
    expect(page).to have_button("Request booking")
  end

  scenario 'User can select dates' do
    visit('/spaces/1')
    expect(page).to have_css('.date_selector')
  end

  scenario 'throws error if no date is selected' do
    visit('/spaces/1')
    click_button 'Request booking'
    expect(page).to have_css('.notice')
  end

  describe 'user has entered a valid date' do

    before(:each) do
      visit('/spaces/1')
      fill_in('booking_date', with: '01-05-2021')
      click_button 'Request booking'
    end

    scenario 'can go back to the space page from requests' do
      visit('/requests/users/1')
      click_button('Show the space')
      expect(page).to have_content('Request booking')
    end

    scenario 'Dates are submitted' do
      visit('/requests/users/1')
      expect(page).to have_css('.space_title')
      expect(page).to have_content("1 - May - 2021")
    end

    scenario 'Booking information displayed' do
      expect(page).to have_content('unconfirmed')
    end

  end

end
