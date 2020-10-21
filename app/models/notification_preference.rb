class NotificationPreference < ApplicationRecord
  belongs_to :user

  before_destroy :remove_from_mailjet

  def remove_from_mailjet
    require 'mailjet'

    Mailjet.configure do |config|
      config.api_key = Rails.application.credentials[:mailjet_market][:api_key]
      config.secret_key = Rails.application.credentials[:mailjet_market][:api_secret]
      config.api_version = "v3"
    end
    begin
      variable = Mailjet::Contact.find(self.user.email)
      variable.update_attributes(is_excluded_from_campaigns: "true") if variable.present?
    end
  end
end
