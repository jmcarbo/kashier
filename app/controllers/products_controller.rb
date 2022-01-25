class ProductsController < ApplicationController
  before_action :set_product, only: %i[ destroy ]

  def index
    @products = Product.all
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: "Product was successfully created." }
      else
        format.html { redirect_to products_url, notice: "Error adding product" }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_params
    params.require(:product).permit(:code, :name, :price, :price_discount_type, :from_amount, :discount_value)
  end
end

