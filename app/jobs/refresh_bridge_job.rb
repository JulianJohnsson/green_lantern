class RefreshBridgeJob < ApplicationJob
  queue_as :default

  def perform(account)
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet][:api_secret]
      config.default_from = 'emmanuel@hellocarbo.com'
      config.api_version = 'v3.1'
    end
    @account = account
    @user = @account.user
    if @user.present?
      begin
        variable = Mailjet::Send.create(messages: [{
            'From'=> {
              'Email'=> "julien@hellocarbo.com",
              'Name'=> "Julien de Carbo"
            },
            'To'=> [
              {
                'Email'=> @user.email,
                'Name'=> (@user.name||"")
              }
            ],
            'TemplateID'=> 1110159,
            'TemplateLanguage'=> true,
            'Subject'=> "Ton impact carbone n'est plus à jour 🚨",
            'Variables'=> {
              "name" => (@user.name||""),
              "technical_reason" => @account.status_info
            }
        }])
        p variable.attributes['Messages']

        rescue Net::HTTPRetriableError => e
        puts e.message
      end
    end
  end

end
