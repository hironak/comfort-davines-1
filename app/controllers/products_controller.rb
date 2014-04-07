class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_title, only: [:show]

  def index
    @products = Product.available
  end

  def newitems
    title "New Item"
    @products = Product.new_items
  end

  def ranking
    title "ランキング"
    @products = Product.ranking
  end

  # GET /products/1
  # GET /products/1.json
  def show
    redirect_to root_path and return unless @product.showable?
    if Rails.env.production?
      if @product.series.singleton and !respond_as_mobile?
        redirect_to catalog_path(action: :series, id: @product.series.identify, anchor: @product.slug) and return
      end
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
