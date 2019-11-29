class DriftOnboardingJob < ApplicationJob
  queue_as :default

  def perform(user)
    variable = Mailjet::Send.create(messages: [{
        'From'=> {
          'Email'=> "emmanuel@hellocarbo.com",
          'Name'=> "Emmanuel de Carbo"
        },
        'To'=> [
          {
            'Email'=> user.email,
            'Name'=> user.name
          }
        ],
        'TemplateID'=> 1111273,
        'TemplateLanguage'=> true,
        'Subject'=> "Finalise ton parcours Carbo ici",
        'Variables'=> {
          "name" => user.name
        }
      }])
      p variable.attributes['Messages']
  end

end
