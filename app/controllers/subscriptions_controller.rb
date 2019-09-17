class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @subscription = Subscription.new
    @user = current_user
  end

  def show
  end

  def create
    @subscription = Subscription.new(subscription_params)

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to @subscription, notice: 'Merci et bravo pour votre engagement ! Nous allons traiter votre demande et vous contacter dans les prochaines heures.' }
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
