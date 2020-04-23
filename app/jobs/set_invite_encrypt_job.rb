class SetInviteEncryptJob < ApplicationJob

  def perform(user)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
    user.invite_encrypt = crypt.encrypt_and_sign(user.email)
    while user.invite_encrypt.include?("+")
      user.invite_encrypt = crypt.encrypt_and_sign(user.email)
    end
    user.save
  end

end
