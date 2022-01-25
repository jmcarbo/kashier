require 'rails_helper'

RSpec.describe "CashRegisters", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "View empty cash_register" do
    visit '/cash_register'
    expect(page).to have_content('Cash Register')
  end

  it "Add product to cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    visit '/cash_register'

    expect(page).to have_content('GR1 - Green Tea (3.11€)') 
    expect(page).not_to have_content('Product Code') 
    click_on 'Add Product'

    cash_register = CashRegister.first
    expect(cash_register.id).to be >=1
    expect(cash_register.cash_register_lines.first).to be_valid
  end

  it "Display products in cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    visit '/cash_register'

    expect(page).to have_content('GR1 - Green Tea (3.11€)') 
    expect(page).not_to have_content('Product Code') 
    click_on 'Add Product'

    expect(page).to have_content('Product Code') 
  end

  it "Display gross total amount in cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    expect(page).to have_content('GR1 - Green Tea (3.11€)') 
    expect(page).not_to have_content('Product Code') 

    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('19.34€') 
  end

  it "Display discount and total amount in cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    expect(page).to have_content('GR1 - Green Tea (3.11€)') 
    expect(page).not_to have_content('Product Code') 

    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('19.34€') 
    expect(page).to have_content('Free products: GR1 x 1.0') 
  end

  it "Display TEST 1 cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    #GR1,SR1,GR1,GR1,CF1
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('22.45€') 
    expect(page).to have_content('Free products: GR1 x 1.0') 
  end

  it "Display TEST 2 cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    #GR1,GR1
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('3.11€') 
    expect(page).not_to have_content('Free products: GR1 x 1.0') 
  end

  it "Display TEST 3 cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    #SR1,SR1,GR1,SR1
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('16.61€') 
    expect(page).to have_content('Free products: GR1 x 1.0') 
  end

  it "Display TEST 4 cash_register" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit '/cash_register'

    #GR1,CF1,SR1,CF1,CF1
    select 'GR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'SR1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'
    select 'CF1', from: 'cash_register_line[product_id]'
    click_on 'Add Product'

    expect(page).to have_content('30.57€') 
    expect(page).to have_content('Free products: GR1 x 1.0') 
  end
end
