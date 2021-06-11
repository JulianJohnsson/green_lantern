# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def create
    super

    begin
      if cookies[:context] == "LBP"
        resource.context = 'lbp'
        resource.save
      end
      utm = cookies[:utm]
      if utm
        resource.utm_params = utm
        resource.save
      end
    rescue => exc
      Rails.logger.error "Error reading utm cookie due to #{exc}"
    end
  end

  # GET /resource/edit
  def edit
    render :layout => 'application'
  end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  def update_resource(resource, params)
    # Require current password if user is trying to change password.
    return super if params["password"]&.present?

    # Allows user to update registration information without password.
    resource.update_without_password(params.except("current_password"))
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :city, :birthdate, :gaid, :utm_params, :context])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :last_name, :city, :birthdate, :gaid, :utm_params, :context, preferences_attributes: [:id, :user_id, :city, :regime, :energy_contract]])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  def after_update_path_for(resource)
      edit_user_registration_path
  end
end
