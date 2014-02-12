json.array!(@templates) do |template|
  json.extract! template, :id
  json.url admin_template_url(template, format: :json)
end
