require Rails.root.join('config/environments/production')

Commers::Application.configure do
  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_url_options = {
    host: ENV['HOSTNAME'] || 'dev.davines.co.jp'
  }
end
