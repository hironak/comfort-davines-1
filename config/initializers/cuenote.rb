Cuenote::Api.configure do |config|
  config.endpoint = ENV['CUENOTE_ENDPOINT']
  config.username = ENV['CUENOTE_USERNAME']
  config.password = ENV['CUENOTE_PASSWORD']
end
