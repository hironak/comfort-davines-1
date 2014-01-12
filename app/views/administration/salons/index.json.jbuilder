json.array!(@salons) do |salon|
  json.extract! salon, :id, :name
  json.url admin_salon_url(salon, format: :json)
end
