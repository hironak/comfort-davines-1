json.array!(@reviews) do |review|
  json.extract! review, :id, :body, :accepted
  json.url admin_review_url(review, format: :json)
end
