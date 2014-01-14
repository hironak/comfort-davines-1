json.array!(@salons) do |salon|
  json.extract! salon, :id, :name
end
