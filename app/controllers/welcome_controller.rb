class WelcomeController < ApplicationController
  def index
    @reviews = Product::Review.limit(3)
  end

  def introduction
    title "初めての方へ"
  end

  def about
    title "ダヴィネスとは"
  end

  def utilization
    title "ショッピングガイド"
    @utilization = File.read("#{Rails.root}/UTILIZATION.md")
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

  def privacypolicy
    title "プライバシーポリシー"
    @policy = File.read("#{Rails.root}/PRIVACYPOLICY.md")
  end

  def shops
    title "店舗情報"
  end
end
