class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def index
  end

  def orders
    @orders = current_consumer.orders
  end
end
