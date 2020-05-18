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

  scenario 'Dates are submitted' do
    visit('/spaces/1')
    select("1", :from => "day")
    select("May", :from => "month")
    select("2021", :from => "year")
    click_button 'Request booking'
    expect(page).to have_content("1 - May - 2021")
  end
end
