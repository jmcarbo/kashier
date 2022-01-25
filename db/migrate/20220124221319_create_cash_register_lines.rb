class CreateCashRegisterLines < ActiveRecord::Migration[7.0]
  def change
    create_table :cash_register_lines do |t|
      t.references :cash_register, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
