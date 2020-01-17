class NotificationPreference < ApplicationRecord
  belongs_to :user

  before_destroy :remove_from_mailjet
  require 'cgi'

  def remove_from_mailjet
    begin
      variable = Mailjet::Contact.find(CGI.escape(self.user.email))

      p variable.attributes['Data']

      case variable.code when 200
        id = variable.attribute['Data']['ID']
      end

      rescue Net::HTTPRetriableError => e
      puts e.message
    end

    begin
      response = RestClient::Request.execute(method: :delete,
        url: "https://api.mailjet.com/v4/contacts/#{id}",
        headers: {'user' => "#{Rails.application.credentials[:mailjet][:api_key]}:#{Rails.application.credentials[:mailjet][:api_secret]}"}
      )
      rescue Net::HTTPRetriableError => e
      puts e.message
    end
  end
end
