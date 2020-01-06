class ApplicationMailer < ActionMailer::Base
  default from: "Julien de Carbo <#{Rails.application.secrets.email_provider_username}>"
  layout 'mailer'
end
