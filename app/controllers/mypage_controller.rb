# -*- coding: utf-8 -*-
class MypageController < ApplicationController
  before_filter :authenticate_consumer!

  def information
  end

  def update_information
    current_consumer.attributes = consumer_params
    if current_consumer.save
      redirect_to mypage_information_path, notice: "情報を更新しました"
    else
      render :information
    end
  end

  private

  def consumer_params
    params.require(:consumer).permit(
      :accepted_magazine,
      information_attributes: [
        :family_name,
        :given_name,
        :family_name_kana,
        :given_name_kana,
        :postalcode,
        :prefecture_code,
        :address,
        :building,
        :phone,
      ]
    )
  end
end
