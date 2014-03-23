module Administration
  class SalesController < BaseController
    def index
      @sales = Sale.search(params)
    end

    def products
      @sales = Sale.search_by_products(params)
    end
  end
end
