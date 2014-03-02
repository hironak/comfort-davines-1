json.array!(@administration_reviews) do |administration_review|
  json.extract! administration_review, :id, :body, :accepted
  json.url administration_review_url(administration_review, format: :json)
end
