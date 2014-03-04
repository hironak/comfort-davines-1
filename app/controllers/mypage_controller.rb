# -*- coding: utf-8 -*-
class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def edit
    @edit = Current_consumer.infomation.all
    update
  end
　
  def orders
    @orders = Current_consumer.information.orders
    update
  end
end
