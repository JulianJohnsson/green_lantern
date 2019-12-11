class SignupJob < ApplicationJob
  queue_as :default

  def perform(user)
    if user.present?

      begin
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
            'TemplateID'=> 1112599,
            'TemplateLanguage'=> true,
            'Subject'=> "Bienvenue dans la communauté Carbo 🎉",
            'Variables'=> {
              "name" => user.name
            }
        }])
        p variable.attributes['Messages']

        rescue Net::HTTPRetriableError => e
        puts e.message
      end
    end
  end

end
