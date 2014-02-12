require "digest/sha1"

class Page < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

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

  if Rails.env.development?
    def self.latest_update
      DateTime.now
    end

    def body
      if File.exists? body_file
        File.read body_file
      else
        attributes["body"]
      end
    end

    def style
      if File.exists? style_file
        File.read style_file
      else
        attributes["style"]
      end
    end

    private

    def body_file
      @body_file ||= "#{Rails.root}/presets/views/page/#{self.identify}/body.html"
    end

    def style_file
      @style_file ||= "#{Rails.root}/presets/assets/stylesheets/page/#{self.identify}.css"
    end
  end
end
