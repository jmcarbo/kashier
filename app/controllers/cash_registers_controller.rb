class CashRegistersController < ApplicationController
  before_action :set_cash_register

  def show
    #@cash_register_line = CashRegisterLine.new
  end

  def destroy
    @cash_register.destroy!
    @cash_register = CashRegister.create
    session[:cash_register_id] = @cash_register.id
    redirect_to @cash_register
  end

  private

  def set_cash_register
    @cash_register = CashRegister.find(session[:cash_register_id])
  rescue ActiveRecord::RecordNotFound
    @cash_register = CashRegister.create
    session[:cash_register_id] = @cash_register.id
  end

end
