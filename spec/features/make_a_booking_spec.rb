feature "Making a booking" do
  scenario "User requests a booking" do
    visit("/spaces/1")
    expect(page).to have_button("Request booking")
  end

  scenario 'User can select dates' do
    visit('/spaces/1')
    expect(page).to have_select('month')
  end

  scenario 'User can select dates' do
    visit('/spaces/1')
    expect(page).to have_select('year')
  end

  scenario 'can go back to the space page from requests' do
    visit('/requests/users/1')
    click_button('Show the space')
    expect(page).to have_content('Request booking')
  end

  before(:each) do
    visit('/spaces/1')
    select("1", :from => "day")
    select("May", :from => "month")
    select("2021", :from => "year")
    click_button 'Request booking'
  end

  scenario 'Dates are submitted' do
    visit('/spaces/1')
    select("1", :from => "day")
    select("May", :from => "month")
    select("2021", :from => "year")
    click_button 'Request booking'
    expect(page).to have_content("2021")
  end

  scenario 'Booking information displayed' do
    expect(page).to have_content('unconfirmed')
  end

end
