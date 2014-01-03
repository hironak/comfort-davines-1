module ApplicationHelper
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
    @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
    @@markdown.render(text).html_safe
  end
end
