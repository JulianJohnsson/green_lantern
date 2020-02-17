class SubscriptionActivationJob < ApplicationJob
  queue_as :default

  def perform(user)
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
      config.default_from = 'emmanuel@hellocarbo.com'
      config.api_version = 'v3.1'
    end
    variable = Mailjet::Send.create(messages: [{
        'From'=> {
          'Email'=> "emmanuel@hellocarbo.com",
          'Name'=> "Emmanuel de Carbo"
        },
        'To'=> [
          {
            'Email'=> user.email,
            'Name'=> (user.name||"")
          }
        ],
        'Bcc'=> [
          {
            'Email'=> "hellocarbo.com+1297d75cff@invite.trustpilot.com"
          }
        ],
        'TemplateID'=> 1110052,
        'TemplateLanguage'=> true,
        'Subject'=> "Ton forfait est désormais actif !",
        'Variables'=> {
          "name" => (user.name||""),
          "subscribed" => true,
          "user_plan" => user.subscription_plan,
          "user_carbon_share" => (user.subscription_price/0.02).to_i,
          "user_price" => user.subscription_price,
          "user_plan_share" => (100* user.subscription_price/0.02 / (user.scores.last.total*1000/12).round(0)).to_i
        }
      }])
      p variable.attributes['Messages']
  end

end
