class ApplicationController < ActionController::Base
  include Pundit
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_invitation

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end

  def check_invitation
    if params[:alpha] == "1"
      cookies[:carbo_alpha] = true
    end
    if params[:bridge] == "1"
      cookies[:bridge] = true
    end
  end
end
