class Sale
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  attr_reader :name

  def self.search params
    case params[:type]
    when 'by_year'
      search_by_year
    when 'by_month'
      search_by_month
    else
      search_by_day
    end
  end

  def self.search_by_day
    (1.month.ago.to_date...Date.today).to_a.reverse.map do |date|
      self.new(I18n.l(date), OrderItem.totaling.of_days(date))
    end
  end

  def self.search_by_month
    12.times.map(&:months).map do |months|
      months_ago = months.ago
      self.new("#{months_ago.year}年 #{months_ago.month}月", OrderItem.totaling.of_days(months_ago.beginning_of_month, months_ago.end_of_month))
    end
  end

  def self.search_by_year
    1.times.map(&:year).map do |years|
      years_ago = years.ago
      self.new("#{years_ago.year}年", OrderItem.totaling.of_days(years_ago.beginning_of_year, years_ago.end_of_year))
    end
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
