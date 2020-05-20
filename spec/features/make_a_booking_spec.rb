feature "Making a booking" do
  scenario "User requests a booking" do
    visit("/spaces/1")
    expect(page).to have_button("Request booking")
  end

  scenario 'User can select dates' do
    visit('/spaces/1')
    expect(page).to have_select('day')
    expect(page).to have_select('month')
    expect(page).to have_select('year')
  end

  scenario 'throws error if no date is selected' do
    visit('/spaces/1')
    click_button 'Request booking'
    expect(page).to have_css('.notice')
  end

  describe 'user has entered a valid date' do

    before(:each) do
      visit('/spaces/1')
      select("1", :from => "day")
      select("May", :from => "month")
      select("2021", :from => "year")
      click_button 'Request booking'
    end

    scenario 'can go back to the space page from requests' do
      visit('/requests/users/1')
      click_button('Show the space')
      expect(page).to have_content('Request booking')
    end
  
    scenario 'Dates are submitted' do
      expect(page).to have_content("1 - May - 2021")
    end
  
    scenario 'Booking information displayed' do
      expect(page).to have_content('unconfirmed')
    end
  
  end

end
