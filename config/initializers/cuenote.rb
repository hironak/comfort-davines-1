Cuenote::Api.configure do |config|
  config.endpoint ENV['CUENOTE_ENDPOINT']
  config.user     ENV['CUENOTE_USER']
  config.password ENV['CUENOTE_PASSWORD']
end
