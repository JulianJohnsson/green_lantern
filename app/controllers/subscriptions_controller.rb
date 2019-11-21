class SubscriptionsController < ApplicationController
  layout "stripe"
  before_action :authenticate_user!

  def index
    @score = current_user.scores.last
    @carbone_count = @score.total*1000/12
    @average_price = 15 * @carbone_count / 750
    AnalyticService.new.track('Subscription Viewed', nil, current_user)
  end

  def new
    if current_user.subscribed?
      redirect_to '/subscriptions/show', notice: "You are already a subscriber!"
    end
    @score = current_user.scores.last
    if params[:quantity] == nil && params[:price].present?
      params[:quantity] = params[:price].to_i * 50
    end
    case params[:plan] when 'bonsai'
      @color =  'rose'
      @carbone_count = @score.total*1000/12.to_i
      @price = @carbone_count * 0.02
      @image = 'Bonsai_dark.png'
    when 'cocotier'
      @color =  'orange'
      @carbone_count = @score.total*1000/12.to_i * 2
      @price = @carbone_count * 0.02
      @image = 'Cocotier_dark.png'
    when 'bambou'
      @color =  'warning'
      @price = params[:price].to_i
      @carbone_count = @price * 50
      @image = 'Pousse_dark.png'
    end
    AnalyticService.new.track('Subscription Choosed', nil, current_user)
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

    AnalyticService.new.track('Subscription Paid', nil, current_user)

    redirect_to '/subscriptions/show', notice: "Your subscription was setup successfully!"
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(current_user.stripe_subscription_id).delete
    current_user.update(stripe_subscription_id: nil)
    current_user.subscribed = false

    AnalyticService.new.track('Subscription Cancelled', nil, current_user)

    redirect_to root_path, notice: "Your subscription has been cancelled."
  end

end
