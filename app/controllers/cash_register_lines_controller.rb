class CashRegisterLinesController < ApplicationController
  def create
    cash_register = CashRegister.find(params[:cash_register_id])
    if cash_register 
      line = cash_register.cash_register_lines.new
      line.product_id = params[:cash_register_line][:product_id]
      if line.save
        redirect_to cash_register
      else
      end
    else
    end
  end
end
