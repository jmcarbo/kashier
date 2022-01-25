class CashRegisterLine < ApplicationRecord
  belongs_to :cash_register
  belongs_to :product

end
