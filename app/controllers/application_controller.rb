class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true

  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :capture_utm
  before_action :capture_invite

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end

  private

  def capture_invite
    if params[:invite] != nil && cookies[:invited_by] == nil
      crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base[0..31])
      decrypted_back = crypt.decrypt_and_verify(params[:invite])
      user = User.find_by_email(decrypted_back)
      cookies[:invited_by] = user.id
    end
  end

  def capture_utm
    unless cookies[:utm]
      cookies[:utm] = { :value => utm.to_json, :max_age => "2592000" }
    end
  end

  def utm
    {
      :utm_source => (cookies[:utm_source]||params[:utm_source]||""),
      :utm_campaign => (cookies[:utm_campaign]||params[:utm_campaign]||""),
      :utm_medium => (cookies[:utm_medium]||params[:utm_medium]||""),
      :utm_term => (cookies[:utm_term]||params[:utm_term]||""),
      :utm_content => (cookies[:utm_content]||params[:utm_content]||"")
    }
  end

  def check_onboarding
    if current_user.scores.last == nil
      redirect_to '/onboarding'
    end
  end

end
