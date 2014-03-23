class Sale

  attr_reader :name

  def self.search params
    search_by_day
  end

  def self.search_by_day
    (1.month.ago.to_date...Date.today).to_a.reverse.map do |date|
      self.new(I18n.l(date), OrderItem.totaling.of_days(date))
    end
  end

  def self.search_by_month
  end

  def self.search_by_year
  end

  def self.search_by_products params
    order_items = OrderItem.totaling
    order_items = order_items.of_days(params[:start_date], params[:end_date]) if params[:start_date] && params[:end_date]
    Product.all.map do |product|
      self.new(product.admin_name, order_items.where(product_id: product.id))
    end
  end

  def initialize name, order_items
    @name = name
    @order_items = order_items
  end

  def amount
    @order_items.map(&:amount).inject(:+).to_i
  end

  def total_price
    @order_items.map(&:price).inject(:+).to_i
  end
end
