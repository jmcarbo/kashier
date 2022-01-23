require 'rails_helper'

RSpec.describe "Welcome", type: :system do
  before do
    driven_by(:rack_test)
  end

  #pending "add some scenarios (or delete) #{__FILE__}"
  it 'Displays welcome page' do
    visit '/'
    expect(page).to have_content('Welcome to Kashier')
  end
  
  it 'Press products to access product CRUD' do
    visit '/'
    
    click_on "Products"

    expect(page).to have_content('Product List')
  end
end
