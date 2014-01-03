class ProductsController < ApplicationController
  before_action :set_product, only: [:show]

  # GET /products
  # GET /products.json
  def index
    @products = Product.avaiable.load
  end

  # GET /products/1
  # GET /products/1.json
  def show
    if @page = @product.page
      scss = render_to_string('editable', formats: :scss)
      @editable_style = Sass::Engine.new(scss, syntax: :scss).render
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.avaiable.find(params[:id])
  end
end
