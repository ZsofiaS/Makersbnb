require 'orderly'
feature 'space' do

  scenario 'sort by price low to high' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    visit('/spaces')
    click_button('Price: low to high')
    expect("Mars").to appear_before("Pluto")
  end
  scenario 'sort by high to low ' do
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    visit('/spaces')
    click_button('Price: high to low')
    expect("Pluto").to appear_before("Mars")
  end

  scenario 'have link to booking of space ' do
    DatabaseConnection.query("INSERT INTO users (id, username, name, email, password) VALUES (2, 'tanil', 'Joe Bloggs', 'tanil@hotmail.com', '#{BCrypt::Password.create('12345')}');")
    DatabaseConnection.query("INSERT INTO spaces (id, name, description, price, available_from, available_to, user_id) VALUES (3, 'Pluto', 'WORST PLANET TO LIVE', '1200', '2030-10-10', '2040-10-12', 2);")
    visit('/users/log-in')
    fill_in('username', with: 'Joe1984')
    fill_in('password', with: '12345')
    click_button('submit')
    visit('/spaces')
    click_button('Book Space', match: :first)
    expect(page).to have_content("Request booking")
  end


  #scenario 'sort by between start and end day' do
   # visit('/spaces')
    #fill_in('checkin_date', with:'2020-10-9')
    #fill_in('checkout_date', with:'2020-12-13')
    #click_button('find dates')
    #expect("Mars").to appear_before("Pluto")
  #end
end
