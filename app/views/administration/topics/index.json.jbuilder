json.array!(@topics) do |topic|
  json.extract! topic, :id, :date, :subject, :url
  json.url admin_topic_url(topic, format: :json)
end
