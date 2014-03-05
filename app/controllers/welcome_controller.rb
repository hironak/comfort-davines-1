class WelcomeController < ApplicationController
  def index
    @reviews = Product::Review.limit(3)
  end

  def introduction
    title "初めての方へ"
    add_breadcrumb "初めての方へ"
  end

  def about
    title "ダヴィネスとは"
    add_breadcrumb "ダヴィネスとは"
  end

  def utilization
    title "ショッピングガイド"
    add_breadcrumb "ショッピングガイド"
    @utilization = File.read("#{Rails.root}/UTILIZATION.md")
  end

  def faq
    title "よくあるご質問"
    add_breadcrumb "よくあるご質問"
  end

  def sitemap
    title "サイトマップ"
    add_breadcrumb "サイトマップ"
  end

  def contact
    title "お問い合わせ"
    add_breadcrumb "お問い合わせ"
  end

  def company
    title "会社概要"
    add_breadcrumb "会社概要"
  end

  def tradeinfo
    title "特定商取引に関する記載"
    add_breadcrumb "特定商取引に関する記載"
  end

  def privacypolicy
    title "プライバシーポリシー"
    add_breadcrumb "プライバシーポリシー"
    @policy = File.read("#{Rails.root}/PRIVACYPOLICY.md")
  end

  def shops
    title "店舗情報"
    add_breadcrumb "店舗情報"
  end
end
