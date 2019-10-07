class UsersController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized

  def waitlist
    render :layout => 'bridges'
    @user = current_user
    authorize @user
    AnalyticService.new.identify(current_user,request)
    AnalyticService.new.track('Added to waitlist', nil, current_user)
  end

  def track_trump
    @user = current_user
    authorize @user
    @categories = Category.all.parent_categories
    @transactions =
      {
        1 => {
          l(9.months.ago, format: '%B %y') => 300,
          l(8.months.ago, format: '%B %y') => 340,
          l(7.months.ago, format: '%B %y') => 280,
          l(6.months.ago, format: '%B %y') => 560,
          l(5.months.ago, format: '%B %y') => 292,
          l(4.months.ago, format: '%B %y') => 444,
          l(3.months.ago, format: '%B %y') => 812,
          l(2.months.ago, format: '%B %y') => 303,
          l(1.months.ago, format: '%B %y') => 455,
          l(0.months.ago, format: '%B %y') => 125
        },
        12 => {
          l(9.months.ago, format: '%B %y') => 220,
          l(8.months.ago, format: '%B %y') => 340,
          l(7.months.ago, format: '%B %y') => 180,
          l(6.months.ago, format: '%B %y') => 360,
          l(5.months.ago, format: '%B %y') => 292,
          l(4.months.ago, format: '%B %y') => 344,
          l(3.months.ago, format: '%B %y') => 412,
          l(2.months.ago, format: '%B %y') => 103,
          l(1.months.ago, format: '%B %y') => 355,
          l(0.months.ago, format: '%B %y') => 205
        },
        24 => {
          l(9.months.ago, format: '%B %y') => 100,
          l(8.months.ago, format: '%B %y') => 120,
          l(7.months.ago, format: '%B %y') => 180,
          l(6.months.ago, format: '%B %y') => 60,
          l(5.months.ago, format: '%B %y') => 92,
          l(4.months.ago, format: '%B %y') => 144,
          l(3.months.ago, format: '%B %y') => 212,
          l(2.months.ago, format: '%B %y') => 203,
          l(1.months.ago, format: '%B %y') => 139,
          l(0.months.ago, format: '%B %y') => 65
        },
        25 => {
          l(9.months.ago, format: '%B %y') => 100,
          l(8.months.ago, format: '%B %y') => 120,
          l(7.months.ago, format: '%B %y') => 180,
          l(6.months.ago, format: '%B %y') => 60,
          l(5.months.ago, format: '%B %y') => 92,
          l(4.months.ago, format: '%B %y') => 144,
          l(3.months.ago, format: '%B %y') => 212,
          l(2.months.ago, format: '%B %y') => 203,
          l(1.months.ago, format: '%B %y') => 139,
          l(0.months.ago, format: '%B %y') => 65
        },
        70 => {
          l(9.months.ago, format: '%B %y') => 300,
          l(8.months.ago, format: '%B %y') => 420,
          l(7.months.ago, format: '%B %y') => 380,
          l(6.months.ago, format: '%B %y') => 360,
          l(5.months.ago, format: '%B %y') => 292,
          l(4.months.ago, format: '%B %y') => 244,
          l(3.months.ago, format: '%B %y') => 312,
          l(2.months.ago, format: '%B %y') => 203,
          l(1.months.ago, format: '%B %y') => 320,
          l(0.months.ago, format: '%B %y') => 92
        }
      }

  end

  def compare_trump_greta
  end

  def reduce_trump
  end

  def subscription_trump
  end

  def index
    @users = User.all
    authorize User
  end

  def show
    @user = User.find(params[:id])
    @bridge = Bridge.find_by_user_id(@user.id)
    @list = @bridge.list_accounts(@user)
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
    params.require(:user).permit(:role, :email, :name)
  end

end
