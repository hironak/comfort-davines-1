# -*- coding: utf-8 -*-
class OrderMailer < ActionMailer::Base
  default from: "order@davines.co.jp"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.complete.subject
  #
  def complete to, order
    @order = order
    mail subject: "【davines direct】ご注文ありがとうございました", to: to
  end
end
