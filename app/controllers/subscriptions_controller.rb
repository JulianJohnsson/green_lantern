class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @subscription = Subscription.new
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @average_price = 15 * @carbone_count / 750
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
