require 'rails_helper'

RSpec.describe "CashRegisters", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "View empty cash_register" do
    visit '/cash_register'
    expect(page).to have_content('Cash Register')
  end
end
