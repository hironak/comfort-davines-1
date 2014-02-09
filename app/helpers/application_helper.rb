module ApplicationHelper
  def title_tag
    content_tag("title", @title || @default_title)
  end

  def stylesheet_tag(options = {}, &block)
    content_tag("style", { "type" => Mime::CSS, "media" => "screen" }.merge(options), &block)
  end

  def link_to_back(name = nil, options = nil, html_options = nil, &block)
    if request.referer.present?
      if block_given?
        link_to request.referer, options, &block
      else
        link_to name, request.referer, &block
      end
    else
      ""
    end
  end

  def page_body(text, render_type = 'HTML')
    case render_type
    when 'markdown'
      page_body_markdown(text)
    else
      page_body_html(text)
    end
  end

  def page_body_html(text)
    text.html_safe
  end

  def page_body_markdown(text)
    @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, tables: true, autolink: true, space_after_headers: true)
    @@markdown.render(text).html_safe
  end

  class ::ActionView::Helpers::FormBuilder
    def limited_fields_for attr, *options, &block
      limit = self.object.class.nested_attributes_options[attr.to_sym][:limit].to_i
      objects = self.object.send(attr)
      objects = objects + ([objects.new] * limit)[(objects.count + 1)...limit]
      fields_for attr, objects, *options, &block
    end
  end
end
