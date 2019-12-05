class GiftPaymentJob < ApplicationJob
  queue_as :default

  def perform(gift)
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
        'TemplateID'=> 1118319,
        'TemplateLanguage'=> true,
        'Subject'=> "Mon meilleur cadeau est pour toi :gem:",
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
