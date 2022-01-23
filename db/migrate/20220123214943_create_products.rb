class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.decimal :price
      t.string :price_discount_type
      t.integer :from_amount
      t.decimal :discount_value

      t.timestamps
    end
  end
end
