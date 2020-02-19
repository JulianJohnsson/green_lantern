class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :capture_utm

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
    devise_parameter_sanitizer.permit(:invite, keys: [:name])
  end

  private

  def capture_utm
    unless cookies[:utm]
      cookies[:utm] = { :value => utm.to_json, :max_age => "2592000" }
    end
  end

  def utm
    {
      :utm_source => (cookies[:utm_source]||""),
      :utm_campaign => (cookies[:utm_campaign]||""),
      :utm_medium => (cookies[:utm_medium]||""),
      :utm_term => (cookies[:utm_term]||""),
      :utm_content => (cookies[:utm_content]||"")
    }
  end

  def check_onboarding
    if current_user.scores.last == nil
      redirect_to '/onboarding'
    end
  end

end
