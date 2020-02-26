class DriftDynamicActivationJob < ApplicationJob
  queue_as :default

  def perform(user)
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
      config.default_from = 'emmanuel@hellocarbo.com'
      config.api_version = 'v3.1'
    end
    if user.present? && user.onboarded == true && user.scores.last.kind.to_sym == :static
      variable = Mailjet::Send.create(messages: [{
        'From'=> {
          'Email'=> "emmanuel@hellocarbo.com",
          'Name'=> "Emmanuel de Carbo"
        },
        'To'=> [
          {
            'Email'=> user.email,
            'Name'=> user.name || ""
          }
        ],
        'TemplateID'=> 1166357,
        'TemplateLanguage'=> true,
        'Subject'=> "Un doute, ou un trou de mémoire ?",
        'Variables'=> {
          "name" => user.name || ""
        }
      }])
      p variable.attributes['Messages']
    end
  end

end
