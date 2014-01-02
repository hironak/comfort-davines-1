module ApplicationHelper
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
end
