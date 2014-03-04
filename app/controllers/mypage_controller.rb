# -*- coding: utf-8 -*-
class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def edit
    @edit = current_consumer.information
    update
  end
　
  def orders
    @orders = current_consumer.information.orders
    update
  end
end
