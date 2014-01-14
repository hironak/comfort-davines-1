json.array!(@agencies) do |agency|
  json.extract! agency, :id, :name
  json.url admin_agency_url(agency, format: :json)
end
