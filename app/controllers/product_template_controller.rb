class ProductTemplateController < ApplicationController
  def stylesheets
    unless @editable_style = Rails.cache.read(cache_key)
      @templates = Product::Template.all
      scss = render_to_string('stylesheets', formats: :scss)
      @template_style = Sass::Engine.new(scss, syntax: :scss).render
      Rails.cache.write(cache_key, @template_style)
    end
    render text: @template_style, content_type: Mime::CSS
  end

  private

  def cache_key
    @cache_key ||= Product::Template.cache_key
  end
end
