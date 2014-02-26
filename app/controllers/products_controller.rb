class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_title, only: [:show]

  # GET /products/1
  # GET /products/1.json
  def show
    title @product.name
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.available.find(params[:id])
  end

  def set_title
    title @product.name
  end
end
