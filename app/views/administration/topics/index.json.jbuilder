json.array!(@administration_topics) do |administration_topic|
  json.extract! administration_topic, :id, :date, :subject, :url
  json.url administration_topic_url(administration_topic, format: :json)
end
