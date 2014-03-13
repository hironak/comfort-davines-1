# Be sure to restart your server when you modify this file.

if Rails.env.production?
  Commers::Application.config.session_store :redis_store, key: "_session_id"
else
  Commers::Application.config.session_store :redis_store, key: "_development_session_id"
end
