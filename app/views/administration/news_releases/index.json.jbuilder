json.array!(@news_releases) do |news_release|
  json.extract! news_release, :id, :date, :title, :body
  json.url admin_news_release_url(news_release, format: :json)
end
