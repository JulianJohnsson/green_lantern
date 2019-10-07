class PreferencesController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.preferences == []
      @preference = Preference.new
      @user = current_user
      render :layout => 'bridges'
    else
      redirect_to bridges_path
    end
  end

  def create
    @preference = Preference.new(preference_params)
    @bridge = Bridge.find_by_user_id(current_user.id)
    respond_to do |format|
      if @preference.save
        if request.referer.include? "/users/edit"
          format.html { redirect_to edit_user_registration_path, notice: 'Vos préférences ont bien été mises à jour' }
          format.json { render :show, status: :ok, location: @preference }
        else
          format.html { redirect_to bridges_path, notice: 'Merci ! Vos préférences ont bien été enregistrées' }
          format.json { render :show, status: :created, location: @preference }
        end
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @preference = current_user.preferences.last
    respond_to do |format|
      if @preference.update(preference_params)
        format.html { redirect_to edit_user_registration_path, notice: 'Vos préférences ont bien été mises à jour' }
        format.json { render :show, status: :ok, location: @preference }
      else
        format.html { render edit_user_registration_path }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  protected

  def preference_params
    params.require(:preference).permit(:user_id, :city, :regime, :energy_contract)
  end

end
