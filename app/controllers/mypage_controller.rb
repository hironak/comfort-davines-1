# -*- coding: utf-8 -*-
class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def edit
    @edit = Consumer_information.Current_consumer.infomation
  end
　
  def orders
    @orders = Consumer_information.current_consumer.information.orders
    update
  end
end
