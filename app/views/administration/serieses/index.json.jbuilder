json.array!(@administration_serieses) do |administration_seriese|
  json.extract! administration_seriese, :id, :name
  json.url administration_seriese_url(administration_seriese, format: :json)
end
