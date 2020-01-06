class CustomDeviseMailer < Devise::Mailer
  default from: "Julien de Carbo <#{Rails.application.secrets.email_provider_username}>"

  protected

  def subject_for(key)
    return super  unless key.to_s == 'invitation_instructions'

    I18n.t('devise.mailer.invitation_instructions.subject',
      :invited_by => resource.invited_by.try(:name) || resource.invited_by.try(:email))
  end
end
