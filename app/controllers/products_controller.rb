class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :set_title, only: [:show]

  # GET /products
  # GET /products.json
  def index
    title "商品一覧"
    @products = Product.avaiable.load
  end

  # GET /products/category
  # GET /products/category.json
  def category
    title "カテゴリ一覧"
    @products = Product.avaiable.load
  end

  # GET /products/series
  # GET /products/series.json
  def series
    title "シリーズ一覧"
    @products = Product.avaiable.load
  end

  # GET /products/new_items
  # GET /products/new_items.json
  def new_items
    title "新商品一覧"
    @products = Product.avaiable.load
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.avaiable.find(params[:id])
  end

  def set_title
    title @product.name
  end
end
