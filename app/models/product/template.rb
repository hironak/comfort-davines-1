class Product::Template < ActiveRecord::Base

  include StrictDocument

  # validates :body, html: true
  validates :style, css: true

  def self.cache_key
    Digest::SHA1.hexdigest("latest updated at:#{latest_update}")
  end

  def self.latest
    self.order(updated_at: :desc).first
  end

  def self.latest_update
    latest.try :updated_at || "pages never created."
  end
end
