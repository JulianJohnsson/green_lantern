class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def waitlist
    render :layout => 'devise'
    @user = current_user
    authorize @user
    AnalyticService.new.identify(current_user,request)
    AnalyticService.new.track('Added to waitlist', nil, current_user)
  end

  def index
    @users = User.all
    authorize User
  end

  def accounts
    Account.refresh_accounts(current_user)
    @accounts = current_user.accounts
    @bridge = Bridge.find_by_user_id(current_user.id)
    @redirect_url = @bridge.add_item_url(current_user)
    authorize current_user
  end

  def update
    @user = User.find(params[:id])
    authorize @user
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize user
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def secure_params
    params.require(:user).permit(:role, :email, :name, :gaid, :last_name, :city, :birthdate)
  end

end
