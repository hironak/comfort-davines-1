class EditableController < ApplicationController
  def stylesheets
    unless @editable_style = Rails.cache.read(cache_key)
      @pages = Page.all
      scss = render_to_string('stylesheets', formats: :scss)
      @editable_style = Sass::Engine.new(scss, syntax: :scss).render
      Rails.cache.write(cache_key, @editable_style)
    end
    render text: @editable_style
  end

  private

  def cache_key
    @cache_key ||= Page.cache_key
  end
end
