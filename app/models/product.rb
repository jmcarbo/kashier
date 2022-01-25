class Product < ApplicationRecord
  has_many :cash_register_lines, dependent: :delete_all
  def description
    "#{code} - #{name} (#{price}€)"
  end
end
