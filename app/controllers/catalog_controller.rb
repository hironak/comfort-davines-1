class CatalogController < ApplicationController
  def series
    @series = Series.find(params[:id])
  end

  def category
    @category = Category.find(params[:id])
  end

  def solution
    @solution = Solution.find(params[:id])
  end
end
