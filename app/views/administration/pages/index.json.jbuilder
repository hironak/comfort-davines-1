json.array!(@pages) do |page|
  json.extract! page, :id, :body, :style
  json.url admin_page_url(page, format: :json)
end
