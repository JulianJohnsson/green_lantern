class GiftPaymentJob < ApplicationJob
  queue_as :default

  def perform(gift)
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
            'Email'=> gift.author_email,
            'Name'=> (gift.author_name||"")
          }
        ],
        'Bcc'=> [
          {
            'Email'=> "hellocarbo.com+1297d75cff@invite.trustpilot.com"
          }
        ],
        'TemplateID'=> 1118319,
        'TemplateLanguage'=> true,
        'Subject'=> "Mon meilleur cadeau est pour toi 💎",
        'Variables'=> {
          "gift_name" => gift.recipient_name,
          "name" => gift.author_name,
          "gift_message" => gift.invitation_text,
          "gift_email" => gift.recipient_email
        }
      }])
      p variable.attributes['Messages']
  end

end
