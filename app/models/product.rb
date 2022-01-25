class Product < ApplicationRecord
  has_many :cash_register_lines, dependent: :delete_all

  validates_presence_of :code, :name, :price

  def description
    "#{code} - #{name} (#{price}€)"
  end
end
