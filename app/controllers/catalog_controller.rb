class CatalogController < ApplicationController
  def series
    @catalog = Series.where(identify: params[:id]).first
    title @catalog.name
    add_breadcrumb @catalog.name
    @products = @catalog.products.available
    @reviews = @catalog.reviews
    if params[:category]
      @products = @products
        .includes(:categories)
        .where(categories: { identify: params[:category] })
    end
    render 'show'
  end

  def category
    @catalog = Category.where(identify: params[:id]).first
    title "#{@catalog.name}一覧"
    add_breadcrumb @catalog.name
    @products = @catalog.products.available
    @reviews = @catalog.reviews
    render 'show'
  end

  def solution
    @catalog = Solution.find(params[:id])
    title "お悩み別−#{@catalog.name}"
    add_breadcrumb @catalog.name
    @products = @catalog.products.available
    @reviews = @catalog.reviews
    render 'show'
  end
end
