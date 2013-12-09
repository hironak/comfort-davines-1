json.array!(@administrators) do |administrator|
  json.extract! administrator, :id
  json.url admin_administrator_url(administrator, format: :json)
end
