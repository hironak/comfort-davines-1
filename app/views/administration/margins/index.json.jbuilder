json.array!(@administration_margins) do |administration_margin|
  json.extract! administration_margin, :id
  json.url administration_margin_url(administration_margin, format: :json)
end
