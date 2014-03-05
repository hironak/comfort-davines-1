class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_title, only: [:show]

  # GET /products/1
  # GET /products/1.json
  def show
    redirect_to root_path and return unless @product.showable?
    if @product.series.singleton
      redirect_to catalog_path(action: :series, id: @product.series.identify, anchor: @product.slug) and return
    end
    title @product.name
    add_breadcrumb @product.series.name, catalog_path(action: :series, id: @product.series.identify)
    add_breadcrumb @product.name
    @reviews = @product.reviews
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
