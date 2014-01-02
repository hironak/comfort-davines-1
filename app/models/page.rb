class Page < ActiveRecord::Base
  include StrictDocument

  # validates :body, html: true
  validates :style, css: true
end
