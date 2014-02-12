class Template < ActiveRecord::Base
  include Authority::Abilities
  self.authorizer_name = 'AdministrationAuthorizer'

  has_many :products

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

    def header
      if File.exists? header_file
        File.read header_file
      else
        ""
      end
    end

    def style
      if File.exists? style_file
        File.read style_file
      else
        ""
      end
    end

    private

    def header_file
      @header_file ||= "#{Rails.root}/presets/views/template/#{self.identify}/header.html"
    end

    def style_file
      @style_file ||= "#{Rails.root}/presets/assets/stylesheets/template/#{self.identify}.css"
    end
  end
end
