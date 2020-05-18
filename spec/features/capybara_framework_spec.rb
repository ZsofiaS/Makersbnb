feature 'testing framework' do
  scenario 'root page has message' do
    visit('/')
    expect(page).to have_content('hello')
  end
end