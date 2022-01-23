require 'rails_helper'

RSpec.describe "As Employee Products", type: :system do
  before do
    driven_by(:rack_test)
  end

  it "Display existing products" do
    Product.create!(code: "GR1", name: "Green Tea", price: 3.11, price_discount_type: "extra_unit", from_amount: 1.0, discount_value: 1.0)
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    Product.create!(code: "CF1", name: "Coffe", price: 11.23, price_discount_type: "percent", from_amount: 3.0, discount_value: 2.0/3.0)
    visit "/products"
    expect(page).to have_content("GR1") && have_content("Green Tea") && have_content("3.11") && have_content("extra_unit") && have_content("1.0")
  end

  it "Add new product" do
    visit "/products"
    fill_in 'product[code]', with: 'GR1'
    fill_in 'product[name]', with: 'Green Tea'
    fill_in 'product[price]', with: '3.11'
    select 'Extra Unit', from: 'product[price_discount_type]'
    fill_in 'product[from_amount]', with: '1.0'
    fill_in 'product[discount_value]', with: '1.0'
    click_on "New Product"

    product = Product.order("id").last

    expect(product.code).to eq('GR1')
    expect(product.name).to eq('Green Tea')
    expect(product.price).to eq(3.11)
    expect(product.price_discount_type).to eq('extra_unit')
    expect(product.from_amount).to eq(1.0)
    expect(product.discount_value).to eq(1.0)
  end

  it "Delete existent product" do
    Product.create!(code: "SR1", name: "Strawberries", price: 5.0, price_discount_type: "absolute", from_amount: 3.0, discount_value: 4.5)
    visit "/products"
    click_on "Delete"

    expect(Product.where(code: 'SR1').any?).to be false
  end
end
