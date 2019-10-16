Rails.application.configure do
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: 587,
    domain: "example.com",
    authentication: "plain",
    enable_starttls_auto: true,
    user_name: ENV['GMAIL_ADDRESS'],
    password: ENV['GMAIL_PASSWORD']
  }

  config.action_mailer.default_url_options = {host: 'localhost:3030'}
  config.action_mailer.raise_delivery_errors = true
  # more code here....
 end