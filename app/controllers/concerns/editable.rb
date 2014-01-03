module Editable
  def render_style(style)
    style = render_to_string('editable', locals: { style: style }, formats: :scss)
    Sass::Engine.new(style, syntax: :scss).render
  end
end
