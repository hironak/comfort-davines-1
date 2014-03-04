class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def index
    @name = current_consumer.information.name
  end

  def edit
    @edit = current_consumer.information.edit
  end

  def orders
    @orders = current_consumer.information.orders
    update
  end

  def destory
    @destoroy = current_consumer.information.destoroy
  end

end
