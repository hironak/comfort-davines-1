json.array!(@merchandises) do |merchandise|
  json.extract! merchandise, :price
  json.url admin_merchandise_url(merchandise, format: :json)
end
