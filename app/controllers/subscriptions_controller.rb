class SubscriptionsController < ApplicationController
  layout "stripe"
  before_action :authenticate_user!

  def index
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @average_price = 15 * @carbone_count / 750
  end

  def new
    if current_user.subscribed?
      redirect_to '/subscriptions/show', notice: "You are already a subscriber!"
    end
    if params[:quantity] == nil && params[:price].present?
      params[:quantity] = params[:price].to_i * 50
    end
  end

  def show
  end

  def create
    Stripe.api_key = Rails.application.credentials[:stripe][Rails.env.to_sym][:private_key]

    plan_id = params[:plan_id]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]

    customer = if current_user.stripe_id?
                Stripe::Customer.retrieve(current_user.stripe_id)
               else
                Stripe::Customer.create(email: current_user.email, source: token)
              end

    subscription = customer.subscriptions.create(plan: plan.id, quantity: params[:quantity].to_i)

    options = {
      stripe_id: customer.id,
      stripe_subscription_id: subscription.id,
      subscribed: true
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_type]
    ) if params[:user][:card_last4]

    current_user.update(options)

    redirect_to root_path, notice: "Your subscription was setup successfully!"
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)
    current_user.subscribed = false

    redirect_to root_path, notice: "Your subscription has been cancelled."
  end

end
