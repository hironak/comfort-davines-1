json.array!(@serieses) do |series|
  json.extract! series, :id, :name
  json.url admin_series_url(series, format: :json)
end
