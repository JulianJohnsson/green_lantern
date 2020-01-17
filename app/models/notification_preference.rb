class NotificationPreference < ApplicationRecord
  belongs_to :user

  before_destroy :remove_from_mailjet
  require 'cgi'

  def remove_from_mailjet
    require 'mailjet'
    Mailjet.configure do |config|
      config.api_key = bd281c4033c04da70d582e5512b7c1e7
      config.secret_key = 5ac2629d42ccc1fea72c0c102f170f5f
    end
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
        headers: {'user' => "bd281c4033c04da70d582e5512b7c1e7:5ac2629d42ccc1fea72c0c102f170f5f"}
      )
      rescue Net::HTTPRetriableError => e
      puts e.message
    end
  end
end
