feature 'space' do
  scenario 'order by price' do
    visit('/spaces')
    click_button('order_by_price')
    expect(page).to have_button('order_by_price')
  end
end
