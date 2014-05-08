# -*- coding: utf-8 -*-
class OrderMailer < ActionMailer::Base
  default from: "ダヴィネス ダイレクト\n<order@davines.co.jp>"

  def complete to, order
    @order = order
    mail subject: "【davines direct】ご注文ありがとうございました", to: to
  end

  def shipped to, order
    @order = order
    mail subject: "【davines direct】ご注文の商品を発送いたしました", to: to
  end
end
