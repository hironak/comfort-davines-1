json.array!(@merchandises) do |merchandise|
  json.extract! merchandise, :price
  json.url merchandise_url(merchandise, format: :json)
end
