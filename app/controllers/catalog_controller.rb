class CatalogController < ApplicationController
  def series
    @series = Series.find(params[:id])
    @products = @series.products.available
    if params[:category_id]
      @products = @products
        .includes(:categories)
        .where(categories: { id: params[:category_id] })
    end
  end

  def category
    @category = Category.find(params[:id])
  end

  def solution
    @solution = Solution.find(params[:id])
  end
end
