class CatalogController < ApplicationController
  def series
    @series = Series.where(identify: params[:id]).first
    redirect_to @series.singleton and return if @series.singleton
    title @series.name
    @products = @series.products.available
    if params[:category_id]
      @products = @products
        .includes(:categories)
        .where(categories: { id: params[:category_id] })
    end
  end

  def category
    @category = Category.find(params[:id])
    title "#{@category.name}一覧"
  end

  def solution
    @solution = Solution.find(params[:id])
    title "お悩み別−#{@solution.name}"
  end
end
