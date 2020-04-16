class DriftSubscriptionJob < ApplicationJob
  queue_as :default

  def perform(user)
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
      config.default_from = 'emmanuel@hellocarbo.com'
      config.api_version = 'v3.1'
    end
    if user.present? && user.onboarded == true && user.subscribed != true
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
        'TemplateID'=> 1358718,
        'TemplateLanguage'=> true,
        'Subject'=> "Carbo a besoin de toi pour avancer",
        'Variables'=> {
          "name" => user.name || "",
          "carbon" => (user.scores.last.total*1000/12).to_i
        }
      }])
      p variable.attributes['Messages']
    end
  end

end
