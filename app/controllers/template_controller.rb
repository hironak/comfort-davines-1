class TemplateController < ApplicationController
  def stylesheets
    unless @template_style = Rails.cache.read(cache_key)
      @templates = ::Template.all
      scss = render_to_string('stylesheets', formats: :scss)
      @template_style = Sass::Engine.new(scss, syntax: :scss).render
      Rails.cache.write(cache_key, @template_style)
    end
    render text: @template_style, content_type: Mime::CSS
  end

  private

  def cache_key
    @cache_key ||= ::Template.cache_key
  end
end
