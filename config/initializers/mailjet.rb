# kindly generated by appropriated Rails generator
Mailjet.configure do |config|
  config.api_key = Rails.application.credentials[:mailjet][:api_key]
  config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
  config.default_from = 'emmanuel@hellocarbo.com'
  config.api_version = 'v3.1'
end
