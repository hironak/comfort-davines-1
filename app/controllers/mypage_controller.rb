# -*- coding: utf-8 -*-
class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def update
    @update = Consumer_information.current_consumer
  end
　
  def orders
    @orders = Consumer_information.current_consumer.information.orders
    update
  end
end
