class DriftDynamicActivationJob < ApplicationJob
  queue_as :default

  def perform(user)
    if user.present? && user.onboarded == true && user.scores.last.kind.to_s == :static
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
        'Subject'=> "Pourquoi 2 membres sur 3 activent le mode dynamique",
        'Variables'=> {
          "name" => user.name
        }
      }])
      p variable.attributes['Messages']
    end
  end

end
