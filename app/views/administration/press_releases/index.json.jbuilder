json.array!(@press_releases) do |press_release|
  json.extract! press_release, :id, :magazine, :corner, :products
  json.url admin_press_release_url(press_release, format: :json)
end
