class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @subscription = Subscription.new
    @user = current_user
    @carbone_count = current_user.transactions.month_ago(1).sum(:carbone)
    @average_price = 15 * current_user.transactions.six_month.sum(:carbone) / (6*750)
  end

  def show
  end

  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: "Votre demande d'abonnement a bien été prise en compte" }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

  def subscription_params
    params.require(:subscription).permit(:user_id, :plan, :price, :frequency, :start_date, :end_date)
  end

end
