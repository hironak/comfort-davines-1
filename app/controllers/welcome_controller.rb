class WelcomeController < ApplicationController
  before_filter :set_expires

  def index
  end

  def introduction
    title "初めての方へ"
  end

  def about
    title "ダヴィネスとは"
  end

  def utilization
    title "ご利用案内"
  end

  def faq
    title "よくあるご質問"
  end

  def sitemap
    title "サイトマップ"
  end

  def contact
    title "お問い合わせ"
  end

  def company
    title "会社概要"
  end

  def tradeinfo
    title "特定商取引に関する記載"
  end

  def shops
    title "店舗情報"
  end

  private

  def set_expires
    expires_in 5.minutes, public: true
  end
end
