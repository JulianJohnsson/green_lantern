class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def new
    @preference = Preference.new
    @bridge = Bridge.find_by_user_id(current_user.id)
    @user = current_user
    render :layout => 'bridges'
  end

  def create
    @preference = Preference.new(preference_params)
    @bridge = Bridge.find_by_user_id(current_user.id)
    respond_to do |format|
      if @preference.save
        format.html { redirect_to @bridge, notice: 'Merci ! Vos préférences ont bien été enregistrées' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def destroy
  end

  protected

  def preference_params
    params.require(:preference).permit(:user_id, :city, :regime, :energy_contract)
  end

end
