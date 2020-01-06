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
    enrich_utm if request.referer.present?
    {
      :utm_source => (params[:utm_source]||""),
      :utm_campaign => (params[:utm_campaign]||""),
      :utm_medium => (params[:utm_medium]||""),
      :utm_term => (params[:utm_term]||""),
      :utm_content => (params[:utm_content]||"")
    }
  end

  def enrich_utm
    source = URI.parse(request.referer).host
    unless source == Rails.application.secrets.domain_name || params[:utm_source].present? || source == nil
      case when source.include?("google")
        params[:utm_source] = 'google'
        if request.referer.include? "gclid="
          params[:utm_medium] = 'paid'
        else
          params[:utm_medium] = 'organic'
        end
      when source.include?("ecosia")
        params[:utm_source] = source
        params[:utm_medium] = 'organic'
      when source.include?("bing")
        params[:utm_source] = 'bing'
        params[:utm_medium] = 'organic'
      else
        params[:utm_source] = source
        params[:utm_medium] = "referral"
      end
    end
  end

  def check_onboarding
    if current_user.scores.last == nil
      redirect_to '/onboarding'
    end
  end

end
