class CatalogController < ApplicationController
  def series
    @catalog = Series.where(identify: params[:id]).first
    title @catalog.name
    @products = @catalog.products.available
    if params[:category_id]
      @products = @products
        .includes(:categories)
        .where(categories: { id: params[:category_id] })
    end
    render 'show'
  end

  def category
    @catalog = Category.where(identify: params[:id]).first
    title "#{@catalog.name}一覧"
    @products = @catalog.products.available
    render 'show'
  end

  def solution
    @catalog = Solution.find(params[:id])
    title "お悩み別−#{@catalog.name}"
    @products = @catalog.products.available
    render 'show'
  end
end
