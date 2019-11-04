class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_provider_username
  layout 'mailer'
end
