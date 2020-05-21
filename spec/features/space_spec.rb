require 'orderly'
feature 'space' do

  scenario 'sort by price low to high' do
    visit('/spaces')
    click_button('Price: low to high')
    expect("Mars").to appear_before("Pluto")
  end
  scenario 'sort by high to low ' do
    visit('/spaces')
    click_button('Price: high to low')
    expect("Pluto").to appear_before("Mars")
  end

  scenario 'sort by between start and end day' do
    visit('/spaces')
    fill_in('checkin_date', with:'10/10/2020')
    fill_in('checkout_date', with:'10/10/2021')
    click_button('find dates')
    expect("Mars").to appear_before("Pluto")
  end

end
