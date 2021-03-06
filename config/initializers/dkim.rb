if Rails.env.production? && File.exist?('/etc/postfix/dkim.key') && File.readable?('/etc/postfix/dkim.key')
  # Configure dkim globally (see above)
  Dkim::domain      = ENV['HOSTNAME'] || 'davines.co.jp'
  Dkim::selector    = 'mail'
  Dkim::private_key = open('/etc/postfix/dkim.key').read

  # This will sign all ActionMailer deliveries
  ActionMailer::Base.register_interceptor(Dkim::Interceptor)
end
